import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/constant.dart';

class AppointmentListScreen extends StatefulWidget {
  static const route = '/appointment_list_screen';

  const AppointmentListScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentListScreen> createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  late AppoList appoList = AppoList(); // Initialize as an empty AppoList

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                if (appoList.data != null && appoList.data!.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: appoList.data!.length,
                    itemBuilder: (context, index) {
                      final appointment = appoList.data![index];
                      return AppointmentCard(appointment: appointment);
                    },
                  ),
                if (appoList.data == null || appoList.data!.isEmpty)
                  Text("No appointments available"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Appo {
  int? appoId;
  int? doctorId;
  int? paymentId;
  String? appoDt;
  String? appoTime;

  Appo({
    this.appoId,
    this.doctorId,
    this.appoDt,
    this.appoTime,
  });

  factory Appo.fromJson(Map<String, dynamic> json) {
    return Appo(
      appoId: json['appo_id'],
      doctorId: json['doctor_id'],
      appoDt: json['appo_dt'],
      appoTime: json['appo_time'],
    );
  }
}

class AppoList {
  int? error;
  String? message;
  List<Appo>? data;

  AppoList({this.error, this.message, this.data = const []});

  factory AppoList.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? jsonData = json['data'];
    return AppoList(
      error: json['error'],
      message: json['message'],
      data: jsonData != null
          ? jsonData.map((v) => Appo.fromJson(v)).toList()
          : [],
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Appo appointment;

  AppointmentCard({required this.appointment});

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
              'Appointment ID: ${appointment.appoId}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Doctor ID: ${appointment.doctorId}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Date: ${appointment.appoDt}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Time: ${appointment.appoTime}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
