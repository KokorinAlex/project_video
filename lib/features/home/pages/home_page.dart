import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_video/app/constants.dart';
import 'package:project_video/app/delayed_action.dart';
import 'package:project_video/app/models/home_model.dart';
import 'package:project_video/app/widgets/film_card.dart';
import 'package:project_video/data/repositories/films_repository.dart';
import 'package:project_video/features/home/pages/bloc/home_bloc.dart';
import 'package:project_video/features/home/pages/bloc/home_event.dart';
import 'package:project_video/features/home/pages/bloc/home_state.dart';
import 'package:project_video/features/settings/pages/setting_page.dart';
import "dart:math";
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/filter',
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
      body: BlocProvider<HomeBloc>(
          lazy: false,
          create: (BuildContext context) =>
              HomeBloc(context.read<FilmsRepository>()),
          child: const FilmGrid()),
    );
  }
}

class FilmGrid extends StatefulWidget {
  const FilmGrid({Key? key}) : super(key: key);
  static final GlobalKey<State<StatefulWidget>> globalKey = GlobalKey();

  @override
  State<FilmGrid> createState() => _FilmGridState();
}

class _FilmGridState extends State<FilmGrid> {
  final TextEditingController textController = TextEditingController();

  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().add(LoadDataEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: FilmGrid.globalKey,
      onRefresh: _pullToRefresh,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: TextField(
              controller: textController,
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: MovieLocal.search,
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: _onSearchFieldTextChanged,
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (oldState, newState) =>
                oldState.data != newState.data ||
                oldState.favouriteFilms != newState.favouriteFilms,
            builder: (context, state) {
              return FutureBuilder<HomeModel?>(
                future: state.data,
                builder:
                    (BuildContext context, AsyncSnapshot<HomeModel?> data) {
                  return data.connectionState != ConnectionState.done
                      ? const Center(child: CircularProgressIndicator())
                      : data.hasData
                          ? data.data?.results?.isNotEmpty == true
                              ? Expanded(
                                  child: GridView.builder(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      bool isSelected = false;
                                      if (state.favouriteFilms?.isNotEmpty ==
                                          true) {
                                        var moviesFavourite = state
                                            .favouriteFilms
                                            ?.firstWhereOrNull((element) =>
                                                element.id ==
                                                data.data?.results?[index].id);
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
                                            //отправляем событие в блок
                                            context.read<HomeBloc>().add(
                                                  ChangedFavouritesEvent(
                                                    model: data
                                                        .data?.results?[index],
                                                  ),
                                                );
                                          },
                                          filmCardModel:
                                              data.data!.results![index],
                                          key: ValueKey<int>(
                                              data.data?.results?[index].id ??
                                                  -1),
                                        ),
                                      );
                                    },
                                    itemCount: data.data?.results?.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2 / 3,
                                    ),
                                  ),
                                )
                              : const Empty()
                          : const Error();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _onSearchFieldTextChanged(String text) {
    DelayedAction.run(() {
      context.read<HomeBloc>().add(SearchChangedEvent(search: text));
    });
  }

  Future<void> _pullToRefresh() async {
    List refresh = [
      'bad',
      'girl',
      'throne',
      'game',
      'father',
      'family',
      'sister'
    ];
    var i = refresh[Random().nextInt(refresh.length)];
    context.read<HomeBloc>().add(SearchChangedEvent(search: i));
  }
}

class Error extends StatelessWidget {
  const Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      MovieQuery.pisecImageUrl,
      fit: BoxFit.fitWidth,
    );
  }
}

class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      MovieQuery.nothingImageUrl,
      fit: BoxFit.cover,
    );
  }
}
