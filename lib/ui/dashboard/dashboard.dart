import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hophseeflutter/core/constant.dart';
import 'package:hophseeflutter/core/share_preference.dart';
import 'package:hophseeflutter/data/datasource/api_services.dart';
import 'package:provider/provider.dart';

import '../../data/module/doctor_model.dart';
import '../doctordetails/doctor_list_screen.dart';
import '../doctordetails/appoinment.dart';
import '../profile/profile_design.dart';
import 'doctor_card.dart';

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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              HeaderDesign(
                icon: Icons.perm_identity,
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
              const Divider(),
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
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: AdvertisementCard(),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Row(
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Categorieslist1(),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                        'All Doctors',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 170),
                      child: InkWell(
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
                        },
                        child: const Text(
                          'SEE ALL',
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // Doctor list
              DoctorHorizontal(
                data: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderDesign extends StatefulWidget {
  HeaderDesign({
    Key? key,
    required this.icon,
    required this.onPress,
    this.imagePath = "",
    this.endIcon = true,
  }) : super(key: key);
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final String imagePath;

  @override
  State<HeaderDesign> createState() => _HeaderDesignState();
}

class _HeaderDesignState extends State<HeaderDesign> {
  final StreamController<String> _controller = StreamController<String>();

  // Getter to get the stream associated with this controller.
  Stream<String> get stream => _controller.stream;

  final StreamController<String> _image_controller = StreamController<String>();

  // Getter to get the stream associated with this controller.
  Stream<String> get image_stream => _image_controller.stream;

  @override
  Widget build(BuildContext context) {
    changeData();
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<String>(
              stream: image_stream, // Access the custom stream
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue, // Border color
                        width: 3.0, // Border width
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(snapshot.data.toString()),
                    ),
                  );
                } else {
                  return const Text(
                    "Image",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
            const SizedBox(width: 16.0),
            StreamBuilder<String>(
              stream: stream, // Access the custom stream
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.toString(),
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  );
                } else {
                  return const Text(
                    "Name",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void changeData() async {
    Map<String, String?> value =
        await Preference.getUserDetailsFromSharedPreferences();
    print("Name Of the user $value");
    _controller.sink.add(value["name"].toString());
    String imageUrl = value["image_url"].toString();
    print("image_url : $imageUrl");
    _image_controller.sink.add(imageUrl);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.close();
    _image_controller.close();
  }
}

class AdvertisementCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.cyan.shade200,
      elevation: 5, // Add a shadow to the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: Container(
        width: 350,
        padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 150, // Advertisement image height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage('assets/Advertisement.png'),
                  // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'HoPhSee ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Your Health, Our Priority:\nTrust in Excellence, Care with Compassion.',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Services class for Categories
class Categories {
  final String Text;
  final Color color;

  Categories({
    required this.Text,
    required this.color,
  });
}

// Services List OF DATA
List<Categories> Categorieslist = [
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

class Categorieslist1 extends StatelessWidget {
  const Categorieslist1({super.key});

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
              children: Categorieslist.map(
                (e) => CupertinoButton(
                  onPressed: () {
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
                  },
                  padding: const EdgeInsets.only(left: 15),
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
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorHorizontal extends StatelessWidget {
  List<Doctor> data;
  DoctorHorizontal({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(0),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          Doctor doctor = data[index];
          return DoctorCard(
            name: "${doctor.doctorName}",
            description: "${doctor.briefDesc}",
            imagePath: "$host/${doctor.imageUrl}", // Use custom image
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppointmentDesign1(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
