import 'package:flutter/material.dart';
import 'package:github_api_task/src/features/favorites/presentation/favorite_page.dart';
import 'package:github_api_task/src/presentation/fun_test.dart';
import 'package:github_api_task/src/presentation/pages/search_user_page.dart';
import 'package:quick_actions/quick_actions.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});
  static const String routeName = '/';

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  int _selectedIndex = 0;
  QuickActions quickActions = const QuickActions();
  static const List<Widget> _widgetOptions = <Widget>[
    SearchUserPage(),
    FavoritesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  initState() {
    super.initState();
    initialQuickActions();
  }

  initialQuickActions() {
    quickActions.initialize(
      (shortcutType) {
        switch (shortcutType) {
          case "test":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FunTest()));
            return;
          default:
        }
      },
    );

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(type:'test' , localizedTitle: "don't remove app",icon:'emoji' ),  
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
