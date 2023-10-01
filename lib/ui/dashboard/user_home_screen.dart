import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../appointment/appointment_screen.dart';
import '../doctordetails/doctor_list_screen.dart';
import '../profile/profile_design.dart';
import 'dashboard.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);
  static const route = '/user_screen';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<UserHomeScreen> {
  final items = const [
    Icon(
      Icons.home_outlined,
      size: 30,
    ),
    /*
    Icon(
      Icons.calendar_today,
      size: 30,
    ),*/
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
        color: Colors.lightBlueAccent,
        // Set the color to blue
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const MyHome();
        break; /*
      case 1:
        widget = const AppointmentScreen();
        break;*/
      case 1:
        widget = DoctorListScreen();
        break;
      case 2:
        widget = const ProfileDesign();
        break;
      default:
        widget = const MyHome();
        break;
    }
    return widget;
  }
}
