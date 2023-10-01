import 'package:flutter/material.dart';

import '../../core/constant.dart';
import '../../data/module/doctor_model.dart';
import '../appointment/appointment_screen.dart';
import 'doctor_card.dart';

class DoctorsListView extends StatelessWidget {
  List<Doctor> data;

  DoctorsListView({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        Doctor doctor = data[index];
        return DoctorCard(
          name: "${doctor.doctorName}",
          description: "${doctor.briefDesc}",
          imagePath: doctor.imageUrl ?? "", // Use custom image
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppointmentScreen(doctor: doctor),
              ),
            );
          },
        );
      },
    );
  }
}
