import 'package:cached_network_image/cached_network_image.dart';
import 'package:project_video/app/constants.dart';
import 'package:project_video/app/models/film_card_model.dart';
import 'package:project_video/app/widgets/details_page.dart';
import 'package:project_video/app/widgets/like_button.dart';
import 'package:project_video/app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class FilmCard extends StatelessWidget {
  const FilmCard({
    required this.id,
    required this.title,
    required this.picture,
    required this.voteAverage,
    required this.releaseDate,
    required this.description,
    Key? key,
  }) : super(key: key);

  factory FilmCard.fromModel({
    required FilmCardModel model,
    Key? key,
  }) {
    return FilmCard(
      id: model.id,
      title: model.title,
      picture: model.picture,
      voteAverage: model.voteAverage,
      key: key,
      description: model.description,
      releaseDate: model.releaseDate,
    );
  }

  final int id;
  final String title;
  final String? picture;
  final double? voteAverage;
  final String? releaseDate;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            offset: Offset(1, 2),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: picture!,
                errorWidget: (_, __, ___) =>
                    Image.network(MovieQuery.pisecImageUrl),
                cacheManager: MoviePictures.pictureCache,
              ),
            ),
          ),
          Positioned(
            right: 4,
            top: 4,
            child: _RatingChip(voteAverage!),
          ),
          const Positioned(
            left: 4,
            child: LikeButton(),
          ),
          Positioned(
            left: 8,
            right: 8,
            bottom: 8,
            child: PrimaryButton(
              'More',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: DetailsArguments(
                    id,
                    title,
                    picture!,
                    voteAverage ?? 0,
                    releaseDate ?? ' ',
                    description ?? ' ',
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: NameFilm(title: title),
          ),
        ],
      ),
    );
  }
}

class _RatingChip extends StatelessWidget {
  const _RatingChip(this.voteAverage, {Key? key}) : super(key: key);

  final double voteAverage;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(
        Icons.star,
        color: Colors.yellow,
      ),
      label: Text(
        voteAverage.toStringAsFixed(1),
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}

class NameFilm extends StatelessWidget {
  const NameFilm({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          shadows: <Shadow>[
            Shadow(
              offset: Offset(5, 5),
              blurRadius: 10.0,
              color: Colors.black,
            ),
            //
          ],
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
