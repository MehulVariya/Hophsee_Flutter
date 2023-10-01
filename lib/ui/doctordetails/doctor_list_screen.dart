import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hophseeflutter/data/datasource/api_services.dart';
import 'package:hophseeflutter/data/module/doctor_model.dart';
import 'package:hophseeflutter/ui/dashboard/doctors_list_view.dart';

import '../../core/widget/custome_app_bar.dart';
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
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            CustomAppBar(
                icon: Icons.cabin_outlined,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileDesign(),
                    ),
                  );
                }),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: DoctorsListView(
                data: widget.doctorList?.data ?? [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
