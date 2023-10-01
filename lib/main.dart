// ignore: avoid_web_libraries_in_flutter

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hophseeflutter/ui/dashboard/HomeScreen.dart';
import 'package:hophseeflutter/ui/dashboard/dashboard.dart';
import 'package:hophseeflutter/ui/doctorpannel/doctor_home_screen.dart';
import 'package:hophseeflutter/ui/home/login_screen.dart';
import 'package:hophseeflutter/ui/splash/splash_screen.dart';

void main() {
  runApp(DevicePreview(
    builder: (BuildContext c) {
      return MyApp();
    },
    enabled: !kReleaseMode,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light, // Set the default theme to light
        // Define other theme properties like colors, text styles, etc.
      ),
      /* darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark, // Set the dark theme
        // Define dark theme properties.
      ),*/
      initialRoute: 'HomeScreen',
      home: const SafeArea(child: SplashScreen()),
    );
  }
}
