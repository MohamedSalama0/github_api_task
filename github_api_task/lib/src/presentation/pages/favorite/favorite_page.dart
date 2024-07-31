import 'package:flutter/material.dart';
import 'package:github_api_task/src/core/resources/app_colors.dart';
import 'package:github_api_task/src/core/resources/app_size_config.dart';
import 'package:github_api_task/src/core/resources/style_manager.dart';
import 'package:github_api_task/src/data/data_source/local_data_source.dart';
import 'package:github_api_task/src/models/github_user_model.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
   final dbHelper = DatabaseHelper.instance;
  List<GithubUser> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final loadedFavorites = await dbHelper.getFavorites();
    setState(() {
      favorites = loadedFavorites;
    });
  }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: sizedH(context) * 0.20,
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        final user = favorites[index];
        return Column(
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
        );
      },
    );
  }
}
