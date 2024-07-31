import 'package:flutter/material.dart';
import 'package:github_api_task/src/core/resources/app_assets.dart';
import 'package:github_api_task/src/core/resources/app_colors.dart';
import 'package:github_api_task/src/core/resources/app_size_config.dart';
import 'package:github_api_task/src/core/utils/router.dart';
import 'package:github_api_task/src/presentation/pages/user_followers_page.dart';

class SearchUserPage extends StatelessWidget {
  static const String routeName = '/search_user_page';
  const SearchUserPage({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: sizedH(context) * 0.30),
                Image.asset(
                  AppAssets.githubLogo,
                  height: sizedH(context) * 0.15,
                ),
                const SizedBox(height: 20),
                SearchBar(
                  controller: controller,
                  hintText: 'Enter a GitHub username',
                  onSubmitted: (String query) {
                    // context.read<GithubUserCubit>().getUserFollowers(SearchUsers(query));
                    if (query.isEmpty) return;
                    pushNamed(context, UserFollowersPage.routeName,
                        arguments: query);
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isEmpty) return;
                    pushNamed(context, UserFollowersPage.routeName,
                        arguments: controller.text);
                  },
                  child: const Text(
                    'Search',
                    style: TextStyle(color: AppTheme.dark),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
