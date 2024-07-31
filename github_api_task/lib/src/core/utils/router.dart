import 'package:flutter/material.dart';
import 'package:github_api_task/src/presentation/pages/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:github_api_task/src/presentation/pages/search_user_page.dart';
import 'package:github_api_task/src/presentation/pages/user_details_page.dart';
import 'package:github_api_task/src/presentation/pages/user_followers_page.dart';

class RoutesHelper {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  static Route generateRoute(
    RouteSettings settings,
  ) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) {
        switch (settings.name) {
          case BottomNavBarView.routeName:
            return const BottomNavBarView();
          case SearchUserPage.routeName:
            return const SearchUserPage();
          case UserDetailsPage.routeName:
                  var arg = settings.arguments as String;
            return UserDetailsPage(username: arg,);
          case UserFollowersPage.routeName:
            var arg = settings.arguments as String;
            return UserFollowersPage(username: arg);

          default:
            return const SearchUserPage();
        }
      },
    );
  }
}

void pushNamedAndRemoveUntil(context, route, {arguments}) {
  // Navigator.of(context).pu
  Navigator.pushNamedAndRemoveUntil(
    context,
    route,
    arguments: arguments,
    (Route<dynamic> route) => false,
  );
}

void pushNamed(context, route, {arguments, bool rootNavigator = true}) {
  Navigator.of(context, rootNavigator: rootNavigator).pushNamed(
    route,
    arguments: arguments,
  );
}
