import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final void Function() onClick;
  final DateTime selectedDate; // Add selectedDate parameter

  const CustomDatePicker({
    Key? key,
    required this.onClick,
    required this.selectedDate, // Initialize selectedDate parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: 50,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey.shade500),
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.calendar_month,
                color: Colors.grey,
              ),
              const SizedBox(width: 14),
              Text(
                formattedDate, // Display the formatted date here
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
