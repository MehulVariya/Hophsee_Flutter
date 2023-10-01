import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hophseeflutter/core/share_preference.dart';
import 'package:hophseeflutter/data/datasource/api_services.dart';
import 'package:hophseeflutter/data/module/categories.dart';

import '../ui/dashboard/user_home_screen.dart';

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).clearSnackBars();
  final snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void hideSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
}

void loginUser(ApiServiceImpl apiService, BuildContext context, String email,
    String password) {
  apiService.loginUser(email, password).then((value) {
    if (value.error == 0) {
      if (value.data?.userId != null) {
        var user = value.data;
        Preference.putDataUserDetails(
            user?.userName, user?.imageUrl, user?.userId);
        Navigator.pushNamedAndRemoveUntil(
            context, UserHomeScreen.route, (route) => false);
      } else {
        showSnackbar(context, "Something went wrong try again");
      }
    } else {
      showSnackbar(context, "invalid email or password");
    }
  }, onError: (error) {
    showSnackbar(context, "Something went wrong try again");
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

Future<void> delay(int second) async {
  await Future.delayed(Duration(seconds: second));
  // Your code to be executed after the delay goes here
}

Widget backArrow(BuildContext context){
  return Container(
    height: 40.h,
    width: double.infinity,
    padding: EdgeInsets.only(left: 10.w, right: 10.w),
    child: Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        child: const Icon(Icons.arrow_back_outlined),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}
