import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/utils.dart';
import '../../data/datasource/api_services.dart';
import '../doctordetails/doctor_list_screen.dart';

class DoctorCategoryList extends StatelessWidget {
  const DoctorCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    ApiServiceImpl apiService = ApiServiceImpl(Dio());

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(height: 12),
          SingleChildScrollView(
            child: Row(
              children: getDoctorCategories()
                  .map(
                    (e) => TextButton(
                      onPressed: () {
                        apiService.getDoctorList().then((value) {
                          Navigator.pushNamed(context, DoctorListScreen.route,
                              arguments: value);
                        }, onError: (error) {
                          print(error);
                        });
                      },
                      child: Container(
                        width: 145,
                        height: 60,
                        decoration: BoxDecoration(
                          color: e.color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(e.Text),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
