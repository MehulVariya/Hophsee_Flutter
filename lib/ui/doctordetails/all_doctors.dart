import 'package:flutter/material.dart';

import '../dashboard/home.dart';
import '../profile/profile_design.dart';

class AllDoctorDesign extends StatefulWidget {
  const AllDoctorDesign({super.key});

  @override
  State<AllDoctorDesign> createState() => _AllDoctorDesignState();
}

class _AllDoctorDesignState extends State<AllDoctorDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              HeaderDesign(
                  title: 'Kaushik Variya',
                  icon: Icons.cabin_outlined,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileDesign(),
                      ),
                    );
                  }),
              const Divider(),
              // Padding(
              //   padding: const EdgeInsets.only(top: 25),
              //   child: SizedBox(
              //     width: 350,
              //     child: TextFormField(
              //       decoration: const InputDecoration(
              //           hintText: 'Search',
              //           labelText: 'Search',
              //           prefixIcon: Icon(
              //             Icons.search_outlined,
              //             color: Colors.grey,
              //           ),
              //           errorStyle: TextStyle(fontSize: 20.0),
              //           border: OutlineInputBorder(
              //               borderSide: BorderSide(color: Colors.black),
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(9.0)))),
              //     ),
              //   ),
              // ),
              Text(
                'Here Is The list of all the doctors\nwho are providing services here.',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),

              const Divider(),

              const SizedBox(
                height: 10,
              ),
              const DoctorHorizontal()
            ],
          ),
        ),
      ),
    );
  }
}
