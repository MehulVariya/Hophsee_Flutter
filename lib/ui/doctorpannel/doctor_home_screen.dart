import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hophseeflutter/data/module/user_model.dart';
import '../../core/constant.dart';
import '../../core/widget/custome_app_bar.dart';
import '../../data/datasource/api_services.dart';
import '../../data/module/appo_model.dart';

class DoctorHomeScreen extends StatefulWidget {
  static const route = '/doctor_screen';

  AppoList? appoList;

  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  ApiServiceImpl apiService = ApiServiceImpl(Dio());
  User? user;
  final StreamController<AppoList?> _controller = StreamController<AppoList?>();

  Stream<AppoList?> get stream => _controller.stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.appoList == null) {
      ApiServiceImpl(Dio()).getAppoList().then((value) {
        _controller.sink.add(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            const CustomAppBar(),
            const Divider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: StreamBuilder<AppoList?>(
                  stream: stream, // Access the custom stream
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Container(
                              width: double.infinity,
                              height: 170.h,
                              child: UserListCard(
                                  name: "${user?.userName}",
                                  gender: "${user?.gender}",
                                  age: "${user?.dateOfBirth}",
                                  imagePath: user?.imageUrl ?? "")),
                        ],
                      );
                    }
                    return const Center(
                      child: Text("Please wait.."),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Patient extends StatelessWidget {
  List<User> data;

  Patient({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        User user = data[index];
        return UserListCard(
          name: "${user.userName}",
          gender: "${user.gender}",
          age: "${user.dateOfBirth}",
          imagePath: user.imageUrl ?? "",
        );
      },
    );
  }
}

class UserListCard extends StatelessWidget {
  const UserListCard({
    Key? key,
    required this.name,
    required this.gender,
    required this.age,
    required this.imagePath,
  }) : super(key: key);

  final String name;
  final String gender;
  final String imagePath;
  final String age;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: NetworkImage("$host/$imagePath"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      gender,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      age,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
