import 'package:flutter/material.dart';
import 'package:project_video/features/home/widgets/image_network.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({required this.arguments, Key? key}) : super(key: key);
  static const String routeDetailsName = '/details';
  final DetailsArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                arguments.title,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Expanded(
              flex: 2,
              child: ImageNetwork(arguments.picture),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ),
                  Text(
                    arguments.voteAverage.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 16,
                      color: arguments.voteAverage < 4
                          ? Colors.red
                          : arguments.voteAverage >= 8
                              ? Colors.green
                              : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Дата выхода: ${arguments.releaseDate}',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(arguments.description)
          ],
        ),
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

  final int id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
}


    // Row(
    //     mainAxisSize: MainAxisSize.min,
    //     children: <Widget>[
    //       Flexible(
    //         child: ImageNetwork(arguments.picture),
    //         flex: 1,
    //       ),
    //       Flexible(
    //         flex: 2,
    //         child: Padding(
    //           padding: const EdgeInsets.all(16),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               Text(
    //                 arguments.title,
    //                 style: Theme.of(context).textTheme.headline5,
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(vertical: 8),
    //                 child: Row(
    //                   children: <Widget>[
    //                     const Padding(
    //                       padding: EdgeInsets.only(right: 8),
    //                       child: Icon(
    //                         Icons.star,
    //                         color: Colors.yellow,
    //                       ),
    //                     ),
    //                     Text(
    //                       arguments.voteAverage.toStringAsFixed(1),
    //                       style: TextStyle(
    //                         fontSize: 16,
    //                         color: arguments.voteAverage < 4
    //                             ? Colors.red
    //                             : arguments.voteAverage >= 8
    //                                 ? Colors.green
    //                                 : Colors.black,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 16, bottom: 8),
    //                 child: Text(
    //                   'Дата выхода: ${arguments.releaseDate}',
    //                   style: Theme.of(context).textTheme.headline6,
    //                 ),
    //               ),
    //               Text(arguments.description),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),