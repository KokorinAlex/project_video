import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project_video/app/locals/locals.dart';
import 'package:project_video/app/widgets/details_page.dart';
import 'package:project_video/app/widgets/main_page.dart';
import 'package:project_video/app/widgets/not_found_page.dart';
import 'package:project_video/data/repositories/films_repository.dart';
import 'package:project_video/error_bloc/error_bloc.dart';
import 'package:project_video/error_bloc/error_event.dart';
import 'package:project_video/features/filter/pages/filter_page.dart';
import 'package:project_video/features/filter/widgets/filtering_by_rating.dart';
import 'package:project_video/features/home/pages/bloc/home_bloc.dart';
import 'package:project_video/features/settings/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:project_video/locale_bloc/locale_bloc.dart';
import 'package:project_video/locale_bloc/locale_state.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ErrorBloc>(
      lazy: false,
      create: (_) => ErrorBloc(),
      child: RepositoryProvider<FilmsRepository>(
        lazy: false,
        create: (BuildContext context) => FilmsRepository(
          onErrorHandler: (String code, String message) {
            context
                .read<ErrorBloc>()
                .add(ShowDialogEvent(title: code, message: message));
          },
        ),
        child: BlocProvider<HomeBloc>(
          lazy: false,
          create: (BuildContext context) =>
              HomeBloc(context.read<FilmsRepository>()),
          child: BlocProvider<LocaleBloc>(
            lazy: false,
            create: (_) => LocaleBloc(),
            child: BlocBuilder<LocaleBloc, LocaleState>(
              builder: (context, state) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Films',
                  locale: state.locale,
                  localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                    GlobalWidgetsLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    MyLocalizationsDelegate(initialLocals),
                  ],
                  supportedLocales: availableLocales.values,
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
                    if (settings.name ==
                        FilteringByRating.filterByRatingRouteName) {
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
              },
            ),
          ),
        ),
      ),
    );
  }
}
