import 'package:flutter/material.dart';


class StarRating extends StatelessWidget {
  final int value; // 1..5
  final void Function(int) onChanged;
  const StarRating({super.key, required this.value, required this.onChanged});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) {
        final filled = value >= i + 1;
        return IconButton(
          onPressed: () => onChanged(i + 1),
          icon: Icon(
            filled ? Icons.star : Icons.star_border,
            size: 32,
          ),
        );
      }),
    );
  }
}