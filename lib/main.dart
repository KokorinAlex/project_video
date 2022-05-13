import 'package:project_video/app/widgets/details_page.dart';
import 'package:project_video/app/widgets/main_page.dart';
import 'package:project_video/app/widgets/not_found_page.dart';
import 'package:project_video/features/filter/pages/filter_page.dart';

import 'package:project_video/features/filter/widgets/filtering_by_rating.dart';

import 'package:project_video/features/settings/pages/setting_page.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Films',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
            builder: (context) {
              return const MainPage();
            },
          );
        }
        if (settings.name == FilterPage.path) {
          return MaterialPageRoute(
            builder: (context) {
              return const FilterPage();
            },
          );
        }

        if (settings.name == SettingsPage.routeName) {
          final SettingsArguments arguments =
              settings.arguments as SettingsArguments;
          return MaterialPageRoute(
            builder: (context) {
              return SettingsPage(
                arguments: arguments,
              );
            },
          );
        }

        if (settings.name == DetailsPage.routeDetailsName) {
          final DetailsArguments arguments =
              settings.arguments as DetailsArguments;
          return MaterialPageRoute(
            builder: (context) {
              return DetailsPage(
                arguments: arguments,
              );
            },
          );
        }
        if (settings.name == FilteringByRating.filterByRatingRouteName) {
          final RatingArguments arguments =
              settings.arguments as RatingArguments;
          return MaterialPageRoute(
            builder: (context) {
              return FilteringByRating(
                arguments: arguments,
              );
            },
          );
        }
        return MaterialPageRoute(
          builder: (_) => const NotFoundPage(),
        );
      },
    );
  }
}
