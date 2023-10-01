import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hophseeflutter/core/constant.dart';
import 'package:hophseeflutter/ui/home/login_screen.dart';

import '../../core/share_preference.dart';
import '../../core/utils.dart';
import '../dashboard/user_home_screen.dart';
import '../doctorpannel/doctor_home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void displayContent(BuildContext context) async {
    Map<String, dynamic> data = await Preference.getLoginConfig();
    String navigate = data[IS_LOGIN]
        ? data[IS_DOCTOR_PREFERENCE]
            ? DoctorHomeScreen.route
            : UserHomeScreen.route
        : LoginScreen.route;
    Navigator.pushNamedAndRemoveUntil(context, navigate, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    delay(3).then((_) {
      displayContent(context);
    });
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/applogo.png",
          scale: 2,
        ),
      ),
    );
  }
}
