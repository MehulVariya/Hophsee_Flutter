import 'package:flutter/material.dart';

class TextWithInkwell extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Function onTap;

  const TextWithInkwell({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
            child: Text(firstText),
          ),
          const SizedBox(
            width: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 1.0),
            child: InkWell(
              onTap: () => onTap(),
              child: Text(
                secondText,
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}