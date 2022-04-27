import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({Key? key}) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ChoiceChip(
      selectedColor: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).primaryColor,
      label: _isSelected == false
          ? const Icon(
              Icons.heart_broken,
              color: Colors.white,
            )
          : const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
      selected: _isSelected,
      onSelected: (newBoolValue) {
        setState(() {
          _isSelected = newBoolValue;
        });
      },
    ));
  }
}
