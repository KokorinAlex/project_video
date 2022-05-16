import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_video/app/locals/locals.dart';
import 'package:project_video/app/models/film_card_model.dart';
import 'package:project_video/app/widgets/film_card.dart';
import 'package:flutter/material.dart';
import 'package:project_video/features/home/pages/bloc/home_bloc.dart';
import 'package:project_video/features/home/pages/bloc/home_event.dart';
import 'package:project_video/features/home/pages/bloc/home_state.dart';
import 'package:collection/collection.dart';

class FilteringByRating extends StatelessWidget {
  const FilteringByRating({Key? key, required this.arguments})
      : super(key: key);
  static const String filterByRatingRouteName = '/filterByRating';

  final RatingArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.locale.filterPage),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (oldState, newState) =>
              oldState.data != newState.data ||
              oldState.favouriteFilms != newState.favouriteFilms,
          builder: (context, state) {
            return GridView.builder(
              itemBuilder: (BuildContext context, int index) {
                bool isSelected = false;
                if (state.favouriteFilms?.isNotEmpty == true) {
                  var moviesFavourite = state.favouriteFilms?.firstWhereOrNull(
                      (element) => element.id == arguments.film[index].id);
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
                              model: arguments.film[index],
                            ),
                          );
                    },
                    filmCardModel: arguments.film[index],
                    key: ValueKey<int>(arguments.film[index].id),
                  ),
                );
              },
              itemCount: arguments.film.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
              ),
            );
          },
        ));
  }
}

class RatingArguments {
  const RatingArguments(this.film);
  final List<FilmCardModel> film;
}
