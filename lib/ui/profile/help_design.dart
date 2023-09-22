import 'package:flutter/material.dart';

class HelpMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Help Me'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 10),
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.medical_services,
                    size: 100,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Need Help?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'If you need assistance or have questions, click the button below to seek help.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality to seek help or support here
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Contact Support'),
                            content: Text(
                                'You can reach us at hophseeofficial@gmail.com'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Tap For Help'),
                  ),
                ],
              ),
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Frequently Asked Questions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                FaqItem(
                  question: 'How do I book an appointment?',
                  answer:
                      'To book an appointment, go to the Home screen and tap on "Book Appointment." Select the doctor, choose a date and time, and confirm your booking.',
                ),
                // FaqItem(
                //   question: 'Can I cancel an appointment?',
                //   answer:
                //       'Yes, you can cancel an appointment. Go to the My Appointments screen, find the appointment you want to cancel, and tap on "Cancel Appointment."',
                // ),
                FaqItem(
                  question: 'How do I contact customer support?',
                  answer:
                      'You can contact our customer support team by tapping on the "Contact Support" button on the Profile screen. We are here to help you!',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          question,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(answer),
        Divider(),
      ],
    );
  }
}
