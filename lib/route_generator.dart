import 'package:flutter/material.dart';
import 'package:hophseeflutter/data/module/doctor_model.dart';
import 'package:hophseeflutter/ui/dashboard/user_home_screen.dart';
import 'package:hophseeflutter/ui/doctordetails/doctor_list_screen.dart';
import 'package:hophseeflutter/ui/doctorpannel/doctor_home_screen.dart';
import 'package:hophseeflutter/ui/home/login_screen.dart';
import 'package:hophseeflutter/ui/profile/profile_design.dart';
import 'package:hophseeflutter/ui/splash/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Get the arguments passed when navigating to a screen.
    final args = settings.arguments;

    switch (settings.name) {
      case SplashScreen.route:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case LoginScreen.route:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case UserHomeScreen.route:
        return MaterialPageRoute(builder: (_) => const UserHomeScreen());

      case DoctorHomeScreen.route:
        return MaterialPageRoute(builder: (_) => DoctorHomeScreen());

      case ProfileDesign.route:
        return MaterialPageRoute(builder: (_) => const ProfileDesign());

      case DoctorListScreen.route:
        return MaterialPageRoute(
            builder: (_) => DoctorListScreen(
                  doctorList: args as DoctorList,
                ));

      default:
        // If the route name is not recognized, you can handle it here.
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: const Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}
