import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_video/app/constants.dart';
import 'package:project_video/app/locals/locals.dart';
import 'package:project_video/app/models/film_card_model.dart';
import 'package:project_video/app/widgets/film_card.dart';
import 'package:project_video/data/repositories/films_repository.dart';
import 'package:project_video/error_bloc/error_bloc.dart';
import 'package:project_video/error_bloc/error_event.dart';
import 'package:project_video/features/filter/pages/filter_page.dart';
import 'package:project_video/features/home/pages/bloc/home_bloc.dart';
import 'package:project_video/features/home/pages/bloc/home_event.dart';
import 'package:project_video/features/home/pages/bloc/home_state.dart';
import 'package:project_video/features/settings/pages/setting_page.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: Text(context.locale.favourites),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                FilterPage.path,
              );
            },
            icon: const Icon(Icons.sort),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/settings',
                arguments: const SettingsArguments('BOBIK'),
              );
            },
          ),
        ],
      ),
      body: const FilmList(),
    );
  }
}

class FilmList extends StatefulWidget {
  const FilmList({Key? key}) : super(key: key);

  @override
  State<FilmList> createState() => _FilmListState();
}

class _FilmListState extends State<FilmList> {
  late Future<List<FilmCardModel>> filmsList;

  @override
  void didChangeDependencies() {
    filmsList = FilmsRepository(onErrorHandler: ((String code, String message) {
      context
          .read<ErrorBloc>()
          .add(ShowDialogEvent(title: code, message: message));
    })).getAllFilmsDB();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (oldState, newState) =>
          oldState.data != newState.data ||
          oldState.favouriteFilms != newState.favouriteFilms,
      builder: (context, state) {
        return FutureBuilder<List<FilmCardModel>>(
          future: filmsList,
          builder:
              (BuildContext context, AsyncSnapshot<List<FilmCardModel>> data) {
            return data.connectionState != ConnectionState.done
                ? const Center(child: CircularProgressIndicator())
                : data.hasData
                    ? GridView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          bool isSelected = false;
                          if (state.favouriteFilms?.isNotEmpty == true) {
                            var moviesFavourite = state.favouriteFilms
                                ?.firstWhereOrNull((element) =>
                                    element.id == data.data?[index].id);
                            if (moviesFavourite != null) {
                              isSelected = true;
                            }
                          }

                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: FilmCard(
                              isSelected: isSelected,
                              onChangedFavourites: () {
                                isSelected = !isSelected;

                                context.read<HomeBloc>().add(
                                      ChangedFavouritesEvent(
                                        model: data.data?[index],
                                      ),
                                    );
                              },
                              filmCardModel: data.data![index],
                              key: ValueKey<int>(data.data?[index].id ?? -1),
                            ),
                          );
                        },
                        itemCount: data.data?.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 3,
                        ),
                      )
                    : const Error();
          },
        );
      },
    );
  }
}
