import 'package:flutter/material.dart';
import 'package:hophseeflutter/core/share_preference.dart';
import 'package:hophseeflutter/data/datasource/api_services.dart';
import 'package:hophseeflutter/data/module/categories.dart';

import '../ui/dashboard/HomeScreen.dart';

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).clearSnackBars();
  final snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void loginUser(ApiServiceImpl apiService, BuildContext context, String email,
    String password) {
  apiService.loginUser(email, password).then((value) {
    if (value.error == 0) {
      if (value.data?.userId != null) {
        var user = value.data;
        Preference.putDataUserDetails(
            user?.userName, user?.imageUrl, user?.userId);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false,
        );
      } else {
        showSnackbar(context, "Something went wrong try again");
      }
    } else {
      showSnackbar(context, "invalid email or password");
    }
  }, onError: (error) {
    showSnackbar(context, error.toString());
  });
}

List<Categories> getDoctorCategories() {
  List<Categories> categories = [
    Categories(
      Text: 'Dentists',
      color: const Color(0xffDCEDF9),
    ),
    Categories(
      Text: 'Psychiatrists',
      color: const Color(0xffFAF0DB),
    ),
    Categories(
      Text: 'Surgeons',
      color: const Color(0xffD6F6FF),
    ),
    Categories(
      Text: 'Anesthesiologists',
      color: const Color(0xffF2E3E9),
    ),
    Categories(
      Text: 'Oncologists',
      color: const Color(0xffF2E3E9),
    ),
  ];
  return categories;
}

void hideKeyboard(BuildContext context) {
  final currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}
