import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:project_video/app/constants.dart';
import 'package:project_video/app/locals/locals.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({required this.arguments, Key? key}) : super(key: key);
  static const String routeDetailsName = '/details';
  final DetailsArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.details),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${arguments.title}',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Expanded(
            flex: 2,
            child: CachedNetworkImage(
              imageUrl: '${arguments.picture}',
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) =>
                  Image.network(MovieQuery.pisecImageUrl),
              cacheManager: MoviePictures.pictureCache,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: arguments.voteAverage!.toStringAsFixed(0) != '0'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          context.locale.ratingPrefix,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          arguments.voteAverage!.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 16,
                            color: arguments.voteAverage == null
                                ? Colors.blue
                                : arguments.voteAverage! < 4
                                    ? Colors.red
                                    : arguments.voteAverage! >= 8
                                        ? Colors.green
                                        : Colors.black,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 2),
                          child: Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      context.locale.noRating,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    )),
          Text(
            '${context.locale.releaseDate}${arguments.releaseDate}',
            style: Theme.of(context).textTheme.headline6,
          ),
          Html(data: arguments.description)
        ],
      ),
    );
  }
}

class DetailsArguments {
  const DetailsArguments(
    this.id,
    this.title,
    this.picture,
    this.voteAverage,
    this.releaseDate,
    this.description,
  );

  final int? id;
  final String? title;
  final String? picture;
  final double? voteAverage;
  final String? releaseDate;
  final String? description;
}
