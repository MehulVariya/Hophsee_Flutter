import 'package:flutter/material.dart';

class CommonLabel extends StatelessWidget {
  final String displayText;

  const CommonLabel({super.key, required this.displayText});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          displayText,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ));
  }
}
