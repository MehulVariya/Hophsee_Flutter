import 'package:flutter/material.dart';
import 'package:hophseeflutter/data/module/doctor_model.dart';
import 'package:hophseeflutter/data/module/user_model.dart';

import '../../data/module/appo_model.dart';

class AppointmentCard extends StatelessWidget {
  final String appoDate;
  final String appoTime;
  final String doctorName;

  AppointmentCard(
      {
      /* required this.user, required this.doctor*/
      required this.appoDate,
      required this.appoTime,
      required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Doctor: $doctorName',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Customize the text color
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Date: $appoDate',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey, // Customize the text color
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Time: $appoTime',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey, // Customize the text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
