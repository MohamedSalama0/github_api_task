// create user details page with blocBuilder and contains user photo nad name and below followers and following
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_api_task/src/core/di/injection_container.dart';
import 'package:github_api_task/src/core/resources/app_colors.dart';
import 'package:github_api_task/src/core/resources/app_size_config.dart';
import 'package:github_api_task/src/core/resources/style_manager.dart';
import 'package:github_api_task/src/features/favorites/logic/favorites/cubit/favorites_cubit.dart';
import 'package:github_api_task/src/logic/user_details/cubit/user_details_cubit.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage(
      {super.key, required this.username, required this.index});
  final String username;
  final int index;

  static const String routeName = '/user_details_page';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserDetailsCubit>()..getUserInfo(username),
      child: UserDetailsView(
        username: username,
        index: index,
      ),
    );
  }
}

class UserDetailsView extends StatelessWidget {
  const UserDetailsView(
      {super.key, required this.username, required this.index});
  final String username;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.dark,
        appBar: AppBar(title: Text(username)),
        body: BlocBuilder<UserDetailsCubit, UserDetailsState>(
          builder: (context, state) {
            if (state is UserDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserDetailsLoaded) {
              final user = state.user;
              return Column(
                children: [
                  ListTile(
                    isThreeLine: true,
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(state.user.avatarUrl!),
                    ),
                    trailing: BlocProvider(
                      create: (context) => sl<FavoriteCubit>(),
                      child: BlocBuilder<FavoriteCubit, FavoriteState>(
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                             context
                                  .read<FavoriteCubit>()
                                  .toggleFavorite(user);
                            },
                            child: user.isFavorite ==0
                                ? const Icon(
                                    Icons.star_border,
                                    color: AppTheme.white,
                                  )
                                : const Icon(
                                    Icons.star_purple500_outlined,
                                    color: AppTheme.primaryColor,
                                  ),
                          );
                        },
                      ),
                    ),
                    title: Text(
                      state.user.name ?? '',
                      style: getSemiBoldStyle(color: AppTheme.primaryColor),
                    ),
                    subtitle: Text(
                      state.user.bio ?? 'Bio',
                      style: getMediumStyle(color: AppTheme.white),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(left: sizedW(context) * 0.10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: AppTheme.white,
                        ),
                        SizedBox(width: 20.w),
                        Text(
                          '${state.user.followers.toString()} Followers',
                          style: getRegularStyle(color: AppTheme.white),
                        ),
                        SizedBox(width: 20.w),
                        Text(
                          '${state.user.following.toString()} Following',
                          style: getRegularStyle(color: AppTheme.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(left: sizedW(context) * 0.10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.factory_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20.w),
                        Text(
                          '${state.user.publicRepos.toString()} public repos',
                          style: getRegularStyle(color: AppTheme.white),
                        ),
                        SizedBox(width: 20.w),
                        Text(
                          '${state.user.publicGists.toString()} public gists',
                          style: getRegularStyle(color: AppTheme.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: sizedH(context) * 0.15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.grey,
                    ),
                    onPressed: () {
                      context
                          .read<UserDetailsCubit>()
                          .urlLauncher(state.user.htmlUrl!);
                    },
                    child: Text(
                      'Go to Profile',
                      style: getMediumStyle(color: AppTheme.white),
                    ),
                  )
                ],
              );
            } else if (state is UserDetailsError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}
