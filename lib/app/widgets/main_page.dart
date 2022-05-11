import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_video/data/repositories/films_repository.dart';
import 'package:project_video/error_bloc/error_bloc.dart';
import 'package:project_video/error_bloc/error_event.dart';
import 'package:project_video/features/home/pages/catalog_page.dart';
import 'package:project_video/features/home/pages/home_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static const List<_Tab> _tabs = <_Tab>[
    _Tab(
      icon: Icon(Icons.movie_filter),
      label: 'Catalog',
      page: CatalogPage(title: 'Catalog'),
    ),
    _Tab(
      icon: Icon(Icons.local_movies_outlined),
      label: 'Favourite',
      page: HomePage(title: 'Favourite'),
    ),
  ];

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
    return Scaffold(
      body: BlocProvider<ErrorBloc>(
        lazy: false,
        create: (_) => ErrorBloc(),
        child: RepositoryProvider<FilmsRepository>(
            lazy: true,
            create: (BuildContext context) => FilmsRepository(
                  onErrorHandler: (String code, String message) {
                    context
                        .read<ErrorBloc>()
                        .add(ShowDialogEvent(title: code, message: message));
                  },
                ),
            child: MainPage._tabs.elementAt(_selectedIndex).page),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(
          MainPage._tabs.length,
          (index) {
            final _Tab tab = MainPage._tabs[index];
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

class _Tab {
  const _Tab({required this.icon, required this.page, required this.label});

  final Icon icon;
  final String label;
  final Widget page;
}
