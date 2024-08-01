import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_api_task/src/core/di/injection_container.dart';
import 'package:github_api_task/src/core/resources/app_colors.dart';
import 'package:github_api_task/src/core/resources/app_size_config.dart';
import 'package:github_api_task/src/core/resources/style_manager.dart';
import 'package:github_api_task/src/core/utils/router.dart';
import 'package:github_api_task/src/features/favorites/logic/favorites/cubit/favorites_cubit.dart';
import 'package:github_api_task/src/presentation/pages/user_details_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  // List<GithubUser> favorites = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _loadFavorites();
  // }

  // Future<void> _loadFavorites() async {
  //   final loadedFavorites = await dbHelper.getFavorites();
  //   setState(() {
  //     favorites = loadedFavorites;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FavoriteCubit>(),
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoritesLoaded) {
          final favorites = state.favorites;
            if (favorites.isEmpty) {
              return Center(
                child: Text(
                  'No Users Found',
                  style: getSemiBoldStyle(color: AppTheme.white),
                ),
              );
            }
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: sizedH(context) * 0.20,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final user = favorites[index];
                return GestureDetector(
                  onTap: () {
                    pushNamed(context, UserDetailsPage.routeName,
                        arguments: {'userName': user.name, 'index': index});
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          user.avatarUrl!,
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
                        user.name.toString(),
                        maxLines: 1,
                        style: getMediumStyle(color: AppTheme.white),
                      )
                    ],
                  ),
                );
              },
            );
          }
          if(state is FavoritesError){
               return Center(
                child: Text(
                  state.failMsg,
                  style: getSemiBoldStyle(color: AppTheme.white),
                ),
              );
          }
            return Center(
                child: Text(
                  'There is something wrong',
                  style: getSemiBoldStyle(color: AppTheme.white),
                ),
              );
        },
      ),
    );
  }
}
