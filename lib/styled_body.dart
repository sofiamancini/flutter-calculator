import 'package:flutter/material.dart';

class StyledBodyText extends StatelessWidget {
  const StyledBodyText(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left, // Add default value for textAlign
  });

  final String text;
  final TextAlign textAlign; // Define the textAlign property

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign, // Use the textAlign property
      style: TextStyle(
        color: Colors.brown[900],
        fontSize: 60,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
