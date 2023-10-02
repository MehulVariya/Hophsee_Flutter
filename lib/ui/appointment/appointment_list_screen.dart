import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hophseeflutter/data/datasource/api_services.dart';
import 'package:hophseeflutter/data/module/appo_model.dart';

import 'appointment_card.dart';

class AppointmentListScreen extends StatefulWidget {
  AppointmentListScreen({super.key, this.appoList});

  static const route = '/appointment_list_screen';

  AppoList? appoList;

  @override
  State<AppointmentListScreen> createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.appoList == null) {
      ApiServiceImpl(Dio()).getAppoList().then(
        (value) {
          widget.appoList = value;
          _controller.sink.add(widget.appoList);
        },
        onError: (error) {
          print(error);
        },
      );
    } else {
      _controller.sink.add(widget.appoList);
    }
  }

  final StreamController<AppoList?> _controller = StreamController<AppoList?>();

  // Getter to get the stream associated with this controller.
  Stream<AppoList?> get stream => _controller.stream;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StreamBuilder<AppoList?>(
              stream: stream, // Access the custom stream
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          Appo? appo = snapshot.data?.data?[index];
                          if (appo != null) {
                            return AppointmentCard(
                              appo: appo,
                            );
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
