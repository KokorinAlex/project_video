import 'package:project_video/app/models/film_card_model.dart';
import 'package:project_video/app/widgets/film_tile.dart';
import 'package:flutter/material.dart';

class FilteringByRating extends StatelessWidget {
  const FilteringByRating({Key? key, required this.arguments})
      : super(key: key);
  static const String filterByRatingRouteName = '/filterByRating';

  final RatingArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtering'),
      ),
      body: ListView.builder(
        itemCount: arguments.film.length,
        itemBuilder: (BuildContext context, int index) {
          return FilmTile.fromModel(model: arguments.film[index]);
        },
      ),
    );
  }
}

class RatingArguments {
  const RatingArguments(this.film);
  final List<FilmCardModel> film;
}
