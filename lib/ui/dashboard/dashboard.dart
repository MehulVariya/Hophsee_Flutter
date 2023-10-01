import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hophseeflutter/core/widget/common_label.dart';
import 'package:hophseeflutter/core/widget/common_label_with_tap.dart';
import 'package:hophseeflutter/data/datasource/api_services.dart';
import 'package:hophseeflutter/ui/dashboard/custom_ad.dart';
import 'package:hophseeflutter/ui/dashboard/doctor_category_list.dart';
import 'package:hophseeflutter/ui/dashboard/doctors_list_view.dart';

import '../../core/widget/custome_app_bar.dart';
import '../doctordetails/doctor_list_screen.dart';
import '../profile/profile_design.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  ApiServiceImpl apiService = ApiServiceImpl(Dio());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                icon: Icons.perm_identity,
                backBtn: false,
                onPress: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileDesign(),
                    ),
                    (route) => false,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      labelText: 'Search',
                      prefixIcon: Icon(
                        Icons.search_outlined,
                        color: Colors.grey,
                      ),
                      errorStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: CommonLabel(displayText: "Categories")),
              const SizedBox(
                height: 10,
              ),
              const DoctorCategoryList(),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CommonLabel(displayText: "All Doctors"),
                    CommonLabelWithTap(
                        text: "SEE ALL",
                        onTap: () {
                          apiService.getDoctorList().then((value) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DoctorListScreen(doctorList: value),
                              ),
                              (route) => false,
                            );
                          }, onError: (error) {
                            print(error);
                          });
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: double.infinity,
                height: 300.h,
                child: DoctorsListView(
                  data: [],
                ),
              ),
              const Divider(),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: CommonLabel(displayText: "About Us")),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: AdvertisementCard(),
              ),
              // Doctor list
              /*  Expanded(
                        child:
                        ),
                      ),*/
            ],
          ),
        ),
      ),
    );
  }
}
