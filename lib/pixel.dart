import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Pixel extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var color;
  // ignore: prefer_typing_uninitialized_variables
  var digit;

  Pixel({
    super.key,
    required this.color,            // pixel constructor
    required this.digit,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.all(2),
      child: Center(
        child: Text(
          digit.toString(),     
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
