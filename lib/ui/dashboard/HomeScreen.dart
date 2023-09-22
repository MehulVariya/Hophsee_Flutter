import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../doctordetails/all_doctors.dart';
import '../doctordetails/appoinment.dart';
import '../profile/profile_design.dart';
import 'home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final items = const [
    Icon(
      Icons.home_outlined,
      size: 30,
    ),
    Icon(
      Icons.calendar_today,
      size: 30,
    ),
    Icon(
      Icons.list_alt,
      size: 30,
    ),
    Icon(
      Icons.person_outline,
      size: 30,
    )
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: getSelectedWidget(index: index),
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: index,
        onTap: (selectedIdx) {
          setState(() {
            index = selectedIdx;
          });
        },
        height: 60,
        color: Colors.lightBlueAccent, // Set the color to blue
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const Myhome();
        break;
      case 1:
        widget = const AppointmentDesign1();
        break;
      case 2:
        widget = const AllDoctorDesign();
        break;
      case 3:
        widget = const ProfileDesign();
        break;
      default:
        widget = const Myhome();
        break;
    }
    return widget;
  }
}
