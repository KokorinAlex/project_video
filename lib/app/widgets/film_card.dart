import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_video/app/constants.dart';
import 'package:project_video/app/locals/locals.dart';
import 'package:project_video/app/models/film_card_model.dart';
import 'package:project_video/app/widgets/details_page.dart';
import 'package:project_video/app/widgets/like_button.dart';
import 'package:project_video/app/widgets/primary_button.dart';

class FilmCard extends StatelessWidget {
  final FilmCardModel? filmCardModel;
  final VoidCallback? onChangedFavourites;
  final bool isSelected;

  const FilmCard(
      {Key? key,
      this.filmCardModel,
      this.onChangedFavourites,
      required this.isSelected})
      : super(key: key);

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
                imageUrl: '${filmCardModel?.picture}',
                errorWidget: (_, __, ___) =>
                    Image.network(MovieQuery.pisecImageUrl),
                cacheManager: MoviePictures.pictureCache,
              ),
            ),
          ),
          Positioned(
            right: 4,
            top: 4,
            child: _RatingChip(filmCardModel?.voteAverage),
          ),
          Positioned(
            left: 4,
            child: LikeButton(
              isSelected: isSelected,
              onPressed: () {
                onChangedFavourites?.call();
              },
            ),
          ),
          Positioned(
            left: 8,
            right: 8,
            bottom: 8,
            child: PrimaryButton(
              context.locale.details,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: DetailsArguments(
                    filmCardModel?.id,
                    filmCardModel?.title,
                    filmCardModel?.picture!,
                    filmCardModel?.voteAverage ?? 0,
                    filmCardModel?.releaseDate ?? ' ',
                    filmCardModel?.description ?? ' ',
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: NameFilm(title: '${filmCardModel?.title}'),
          ),
        ],
      ),
    );
  }
}

class _RatingChip extends StatelessWidget {
  const _RatingChip(this.voteAverage, {Key? key}) : super(key: key);

  final double? voteAverage;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(
        Icons.star,
        color: Colors.yellow,
      ),
      label: Text(
        voteAverage?.toStringAsFixed(1) ?? 'Рейтинг отсутствует',
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
