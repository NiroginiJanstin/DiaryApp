import 'package:flutter/material.dart';

Icon returnIcon(rate) {
  switch (rate) {
    case 0:
      return const Icon(
        Icons.sentiment_very_dissatisfied,
        color: Colors.red,
      );
    case 1:
      return const Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.redAccent,
      );
    case 2:
      return const Icon(
        Icons.sentiment_neutral,
        color: Colors.amber,
      );
    case 3:
      return const Icon(
        Icons.sentiment_satisfied,
        color: Colors.lightGreen,
      );
    case 4:
      return const Icon(
        Icons.sentiment_very_satisfied,
        color: Colors.green,
      );
    default:
      return const Icon(
        Icons.sentiment_very_satisfied,
        color: Colors.green,
      );
  }
}
