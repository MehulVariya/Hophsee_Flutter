import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hophseeflutter/data/datasource/api_services.dart';
import 'package:hophseeflutter/data/module/appo_model.dart';
import 'package:hophseeflutter/data/module/doctor_model.dart';

import 'appointment_card.dart';

class AppointmentListScreen extends StatefulWidget {
  AppointmentListScreen({super.key, this.appoList});

  static const route = '/appointment_list_screen';

  AppoList? appoList;

  @override
  State<AppointmentListScreen> createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  ApiServiceImpl apiServices = ApiServiceImpl(Dio());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.appoList == null) {
      apiServices.getAppoList().then(
        (value) {
          Map<String, dynamic> data = {};
          widget.appoList = value;
          data["appolist"] = value.toJson();
          apiServices.getDoctorList().then((value) {
            data["doctorList"] = value.toJson();
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

  final StreamController<Map<String, dynamic>> _controller =
      StreamController<Map<String, dynamic>>();

  // Getter to get the stream associated with this controller.
  Stream<Map<String, dynamic>> get stream => _controller.stream;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StreamBuilder<Map<String, dynamic>>(
              stream: stream, // Access the custom stream
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic>? data = snapshot.data;
                  List<Appo>? appoList =
                      AppoList.fromJson(data?["appolist"]).data;

                  List<Doctor>? doctorList =
                      DoctorList.fromJson(data?["doctorList"]).data;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: appoList?.length,
                        itemBuilder: (BuildContext context, int index) {
                          Appo? appo = appoList?[index];
                          Doctor? doctor = doctorList?.firstWhere((obj) =>
                                  obj.doctorId ==
                                  appo?.doctorId // Provide a default value if the object is not found
                              );
                          if (appo != null) {
                            return AppointmentCard(
                                appoDate: appo.appoDt ?? "",
                                appoTime: appo.appoTime ?? "",
                                doctorName: doctor?.doctorName ?? "");
                          }
                        },
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text("Loading..."),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
