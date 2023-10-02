import 'package:flutter/material.dart';

import '../../data/module/appo_model.dart';

class AppointmentCard extends StatelessWidget {
  final Appo appo;

  AppointmentCard({required this.appo});

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
              'Appointment Id: ${appo.appoId}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Customize the text color
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Doctor: ${appo.doctorId}', // Replace with the actual doctor name
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey, // Customize the text color
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Date: ${appo.appoDt}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey, // Customize the text color
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Time: ${appo.appoTime}',
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
