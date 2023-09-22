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
      appBar: AppBar(
        //title: Text('Help Me'),
        backgroundColor: Colors.white,
      ),
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
              const Text(
                'Here Is The list of all the doctors\nwho are providing services here.',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
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
