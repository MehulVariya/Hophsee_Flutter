import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hophseeflutter/core/constant.dart';
import 'package:hophseeflutter/ui/home/login_screen.dart';

import '../../core/share_preference.dart';
import '../dashboard/HomeScreen.dart';
import '../doctorpannel/doctor_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final StreamController<String> _controller = StreamController<String>();

  // Getter to get the stream associated with this controller.
  Stream<String> get stream => _controller.stream;

  @override
  void initState() {
    displayContent();
    super.initState();
  }

  void displayContent() async {
    Map<String, dynamic> data = await Preference.getLoginConfig();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => data[IS_LOGIN]
            ? data[IS_DOCTOR_PREFERENCE]
                ? DoctorHome()
                : HomeScreen()
            : LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
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
