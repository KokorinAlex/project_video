import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key? key,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  final void Function() onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Icon(isSelected ? Icons.favorite : Icons.heart_broken),
        color: isSelected ? Colors.red : Colors.white,
        onPressed: onPressed,
      ),
    );
  }
}
