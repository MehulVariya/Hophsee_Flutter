import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hophseeflutter/data/datasource/api_services.dart';
import 'package:hophseeflutter/data/module/doctor_model.dart';

import '../dashboard/dashboard.dart';
import '../profile/profile_design.dart';

class DoctorListScreen extends StatefulWidget {
  DoctorList? doctorList;

  DoctorListScreen({this.doctorList, super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.doctorList == null) {
      doctorList();
    }
    print("Doctor List All Doctor : ${widget.doctorList.toString()}");
  }

  void doctorList() async {
    widget.doctorList = await ApiServiceImpl(Dio()).getDoctorList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              HeaderDesign(
                  icon: Icons.cabin_outlined,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileDesign(),
                      ),
                    );
                  }),
              const Divider(),
              const Text(
                'Here Is The list of all the doctors\nwho are providing services here.',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const DoctorHorizontal()
            ],
          ),
        ),
      ),
    );
  }
}
