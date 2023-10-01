import 'package:flutter/material.dart';

class AppointmentListScreen extends StatefulWidget {
  static const route = '/appointment_list_screen';

  const AppointmentListScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentListScreen> createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  // Sample list of appointments
  final List<Appointment> appointments = [
    Appointment(
      patientName: 'John Doe',
      doctorName: 'Dr. Smith',
      date: '2023-09-20',
      time: '10:00 AM',
    ),
    Appointment(
      patientName: 'Jane Smith',
      doctorName: 'Dr. Johnson',
      date: '2023-09-22',
      time: '2:30 PM',
    ),
    // Add more appointments as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /*appBar: AppBar(
          title: Text('My Appointments'),
          backgroundColor: Colors.blue, // Customize the app bar color
        ),*/
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*Text(
                  'Upcoming Appointments',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Customize the text color
                  ),
                ),*/
                SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index];
                    return AppointmentCard(appointment: appointment);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Appointment {
  final String patientName;
  final String doctorName;
  final String date;
  final String time;

  Appointment({
    required this.patientName,
    required this.doctorName,
    required this.date,
    required this.time,
  });
}

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patient: ${appointment.patientName}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Customize the text color
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Doctor: ${appointment.doctorName}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey, // Customize the text color
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Date: ${appointment.date}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey, // Customize the text color
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Time: ${appointment.time}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey, // Customize the text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
