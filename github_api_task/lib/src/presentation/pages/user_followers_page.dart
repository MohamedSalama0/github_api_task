import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_api_task/src/core/di/injection_container.dart';
import 'package:github_api_task/src/core/resources/app_colors.dart';
import 'package:github_api_task/src/core/resources/app_size_config.dart';
import 'package:github_api_task/src/core/resources/style_manager.dart';
import 'package:github_api_task/src/core/utils/router.dart';
import 'package:github_api_task/src/logic/user_followers/cubit/github_user_cubit.dart';
import 'package:github_api_task/src/presentation/pages/user_details_page.dart';

class UserFollowersPage extends StatelessWidget {
  const UserFollowersPage({super.key, required this.username});
  final String username;
  static const String routeName = '/user_followers_page';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GithubUserCubit>()..getUserFollowers(username, 1),
      child: UserFollowersView(username: username),
    );
  }
}

class UserFollowersView extends StatefulWidget {
  final String username;

  const UserFollowersView({super.key, required this.username});

  @override
  _UserFollowersViewState createState() => _UserFollowersViewState();
}

class _UserFollowersViewState extends State<UserFollowersView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.username}\'s Followers')),
      body: BlocBuilder<GithubUserCubit, GithubUserState>(
          buildWhen: (previous, current) => current is! LoadingMoreFollowers,
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: getMediumStyle(color: AppTheme.grey),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppTheme.grey,
                      ),
                      filled: true,
                      fillColor: AppTheme.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      context.read<GithubUserCubit>().filterUsers(value);
                    },
                  ),
                ),
                SizedBox(height: 5.h),
                Expanded(
                  child: _buildContent(context, state),
                ),
              ],
            );
          }),
    );
  }

  void _onScroll(GithubUserState state) async {
    if (state is LoadingMoreFollowers) return;
    if (state is GithubUserFollowersLoaded && !state.hasReachedMax) {
      await Future.delayed(const Duration(seconds: 1));
      // ignore: use_build_context_synchronously
      context.read<GithubUserCubit>().loadMoreUserFollowers();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildContent(BuildContext context, GithubUserState state) {
    if (state is GithubUserFollowersLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is GithubUserFollowersLoaded) {
      if (state.followers.isEmpty) {
        return Center(
          child: Text(
            'No Followers Found',
            style: getMediumStyle(color: AppTheme.white),
          ),
        );
      }
      return NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels ==
                  notification.metrics.maxScrollExtent &&
              notification is ScrollUpdateNotification) {
            _onScroll(state);
          }
          return true;
        },
        child: GridView.builder(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: sizedH(context) * 0.20,
          ),
          itemCount: state.followers.length,
          itemBuilder: (context, index) {
            if (index < state.followers.length) {
              final follower = state.followers[index];
              return GestureDetector(
                onTap: () {
                  pushNamed(context, UserDetailsPage.routeName,
                      arguments: follower.login);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        follower.avatarUrl!,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Container(
                            height: sizedW(context) * 0.29,
                            width: sizedW(context) * 0.29,
                            color: AppTheme.white,
                          );
                        },
                      ),
                    ),
                    Text(
                      follower.login.toString(),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: getMediumStyle(color: AppTheme.white),
                    )
                  ],
                ),
              );
            } else if (!state.hasReachedMax) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      );
    } else if (state is GithubUserFollowersError) {
      return Center(
        child: Text(
          state.message,
          style: getMediumStyle(color: AppTheme.white),
        ),
      );
    }
    return Center(
      child: Text(
        'No followers found',
        style: getMediumStyle(color: AppTheme.white),
      ),
    );
  }
}
