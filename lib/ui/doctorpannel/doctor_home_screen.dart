import 'package:flutter/material.dart';
import '../../core/widget/custome_app_bar.dart';
import '../dashboard/dashboard.dart';
import '../profile/profile_design.dart';

class DoctorHomeScreen extends StatefulWidget {
  static const route = '/doctor_screen';

  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  List<Patient> patients = [
    Patient(
        name: 'Abhay Ambaliya',
        age: 20,
        gender: 'Male',
        profileImageUrl: 'assets/doctor.png'), // Provide the image URL for John
    Patient(
        name: 'Kaushik Variya',
        age: 25,
        gender: 'Male',
        profileImageUrl: 'assets/pimage.png'), // Provide the image URL for Jane
    Patient(
        name: 'Mehul Variya',
        age: 35,
        gender: 'Male',
        profileImageUrl:
            'assets/patient.png'), // Provide the image URL for Michael
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            const CustomAppBar(),
            Divider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  itemCount: patients.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation:
                          5.0, // Add elevation to the cards for a material look
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20.0), // Adjust margin
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              20.0), // Adjust the border radius as needed
                          child: Image.asset(
                            patients[index]
                                .profileImageUrl, // Load the image from the asset
                            fit: BoxFit.cover, // Adjust the image fit
                            width: 40.0,
                            height: 40.0,
                          ),
                        ),
                        title: Text(
                          patients[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, // Bold text
                          ),
                        ),
                        subtitle: Text(
                          'Age: ${patients[index].age} | Gender: ${patients[index].gender}',
                          style: TextStyle(
                            fontStyle: FontStyle.italic, // Italic text
                            color: Colors.grey, // Text color
                          ),
                        ),
                        trailing: const Icon(
                          Icons
                              .arrow_forward, // Add a trailing icon for a more interactive feel
                          color: Colors.blue, // Icon color
                        ),
                        onTap: () {
                          // Add an onTap action when a patient is tapped
                          _showPatientDetails(patients[index]);
                        },
                      ),
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

  // Function to show patient details when tapped
  void _showPatientDetails(Patient patient) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Patient Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${patient.name}'),
              Text('Age: ${patient.age}'),
              Text('Gender: ${patient.gender}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class Patient {
  final String name;
  final int age;
  final String gender;
  final String profileImageUrl;

  Patient(
      {required this.name,
      required this.age,
      required this.gender,
      required this.profileImageUrl});
}
