import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_video/app/constants.dart';
import 'package:project_video/app/models/film_card_model.dart';
import 'package:project_video/app/models/home_model.dart';
import 'package:project_video/data/repositories/films_repository.dart';
import 'package:project_video/error_bloc/error_bloc.dart';
import 'package:project_video/error_bloc/error_event.dart';
import 'package:project_video/features/filter/widgets/filtering_by_rating.dart';
import 'package:flutter/material.dart';
import 'package:project_video/features/home/pages/home_page.dart';
import 'package:project_video/app/locals/locals.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);
  static const path = '/filter';

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final raitingController = TextEditingController();
  Future<HomeModel?>? rep;

  Future<HomeModel?> _getFilm() {
    return FilmsRepository(onErrorHandler: ((String code, String message) {
      context
          .read<ErrorBloc>()
          .add(ShowDialogEvent(title: code, message: message));
    })).loadData(q: 'bad');
  }

  /// Тут пепредаю список фильмов к rep
  @override
  void initState() {
    rep = _getFilm();

    super.initState();
  }

  final List<FilmCardModel> ratingFilms = <FilmCardModel>[];

  /// Фунция фильтрации
  void _filtrationFromRating(List<FilmCardModel> films, String value) {
    ratingFilms.clear();
    final double rating = double.parse(value);
    for (var item in films) {
      if (item.voteAverage! >= rating) {
        ratingFilms.add(item);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.filterPage),
      ),
      body: FutureBuilder<HomeModel?>(
          future: rep,
          builder: (BuildContext context, AsyncSnapshot<HomeModel?> data) {
            return data.connectionState != ConnectionState.done
                ? const Center(child: CircularProgressIndicator())
                : data.hasData
                    ? data.data?.results?.isNotEmpty == true
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                  child: TextField(
                                    controller: raitingController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: context.locale.enterTheRating,
                                      prefixText: '> ',
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 3,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      _filtrationFromRating(data.data!.results!,
                                          raitingController.text);
                                      Navigator.pushNamed(
                                        context,
                                        '/filterByRating',
                                        arguments: RatingArguments(ratingFilms),
                                      );
                                    },
                                    child: Text(context.locale.showButton))
                              ],
                            ),
                          )
                        : const Empty()
                    : const Error();
          }),
    );
  }
}
