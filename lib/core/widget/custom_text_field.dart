import 'package:flutter/material.dart';

class TextFieldDesign extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Icon prefixIcon;
  final bool isObscure;
  final TextEditingController controller;

  const TextFieldDesign(
      {Key? key,
        required this.hintText,
        this.labelText="",
        required this.prefixIcon,
        required this.controller,
        this.isObscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          fillColor: Colors.white38,
          filled: true,
          prefixIcon: prefixIcon,
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}