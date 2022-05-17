import 'package:project_video/features/home/pages/home_page.dart';
import 'package:project_video/features/home/pages/favourite_page.dart';
import 'package:flutter/material.dart';
import 'package:project_video/app/locals/locals.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static bool isEnLocale = false;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<_Tab> _tabs = <_Tab>[
      _Tab(
        icon: const Icon(Icons.movie_filter),
        label: context.locale.catalog,
        page: const HomePage(),
      ),
      _Tab(
        icon: const Icon(Icons.favorite_outlined),
        label: context.locale.favourites,
        page: const FavouritePage(),
      ),
    ];
    return Scaffold(
      body: _tabs.elementAt(_selectedIndex).page,
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(
          _tabs.length,
          (index) {
            final _Tab tab = _tabs[index];
            return BottomNavigationBarItem(
              icon: tab.icon,
              label: tab.label,
            );
          },
        ),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// MainPage._tabs.elementAt(_selectedIndex).page),

class _Tab {
  const _Tab({required this.icon, required this.page, required this.label});

  final Icon icon;
  final String label;
  final Widget page;
}
