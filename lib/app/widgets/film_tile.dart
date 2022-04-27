import 'package:project_video/app/models/film_card_model.dart';
import 'package:project_video/features/home/widgets/Image_network.dart';
import 'package:flutter/material.dart';

class FilmTile extends StatelessWidget {
  const FilmTile(
      {Key? key,
      required this.id,
      required this.title,
      required this.picture,
      required this.voteAverage,
      required this.releaseDate,
      required this.description})
      : super(key: key);
  final int id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;

  factory FilmTile.fromModel({required FilmCardModel model, Key? key}) {
    return FilmTile(
      id: model.id,
      title: model.title,
      picture: model.picture,
      voteAverage: model.voteAverage,
      description: model.description,
      releaseDate: model.releaseDate,
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: ImageNetwork(picture)),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ),
                      Text(
                        voteAverage.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 16,
                          color: voteAverage < 4
                              ? Colors.red
                              : voteAverage >= 8
                                  ? Colors.green
                                  : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    'Дата выхода: $releaseDate',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Text(description),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
