import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hophseeflutter/core/utils.dart';
import 'package:hophseeflutter/data/module/user_model.dart';
import 'package:hophseeflutter/ui/doctorpannel/appo_item_card.dart';
import '../../core/constant.dart';
import '../../core/widget/custome_app_bar.dart';
import '../../data/datasource/api_services.dart';
import '../../data/module/appo_model.dart';
import '../../data/module/doctor_model.dart';

class DoctorHomeScreen extends StatefulWidget {
  static const route = '/doctor_screen';

  AppoList? appoList;

  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  ApiServiceImpl apiService = ApiServiceImpl(Dio());
  final StreamController<Map<String, dynamic>?> _controller =
      StreamController<Map<String, dynamic>?>();

  Stream<Map<String, dynamic>?> get stream => _controller.stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.appoList == null) {
      apiService.getAppoList().then(
        (value) {
          Map<String, dynamic> data = {};
          widget.appoList = value;
          data["appolist"] = value.toJson();
          apiService.getUserList().then((value) {
            data["userList"] = value.toJson();
            _controller.sink.add(data);
          }, onError: (error) {
            print(error);
          });
        },
        onError: (error) {
          print(error);
        },
      );
    }
  }

/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            const CustomAppBar(backBtn : false),
            const Divider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child:
              ),
            ),
          ],
        ),
      ),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomAppBar(backBtn: false),
            Expanded(
              child: StreamBuilder<Map<String, dynamic>?>(
                stream: stream, // Access the custom stream
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic>? data = snapshot.data;
                    List<Appo>? appoList =
                        AppoList.fromJson(data?["appolist"]).data;
                    List<User>? userList =
                        UserModel.fromJson(data?["userList"]).data;
                    print("length of list : ${appoList?.length}");
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(0),
                      itemCount: appoList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        Appo? appo = appoList?[index];
                        User? user = userList?.firstWhere((obj) =>
                                obj.userId ==
                                appo?.userId // Provide a default value if the object is not found
                            );
                        return AppoItemCard(
                          name: "${user?.userName}",
                          gender: "${user?.gender}",
                          age: "${user?.dateOfBirth}",
                          imagePath: user?.imageUrl ?? "",
                        );
                      },
                    );
                  }
                  return const Center(
                    child: Text("Please wait.."),
                  );
                },
              ),
            ),
            SizedBox(height: 5.h,)
          ],
        ),
      ),
    );
  }
}
