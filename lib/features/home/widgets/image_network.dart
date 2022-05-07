import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork(this.picture, {this.fit = BoxFit.fitHeight, Key? key})
      : super(key: key);

  final String picture;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      picture,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      fit: BoxFit.cover,
    );
  }
}
