import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../dashboard/doctor_card.dart';
import '../dashboard/home.dart';
import '../payment/payment_design.dart';
import '../profile/profile_design.dart';

class AppointmentDesign1 extends StatefulWidget {
  const AppointmentDesign1({super.key});

  @override
  State<AppointmentDesign1> createState() => _AppointmentDesignState();
}

class _AppointmentDesignState extends State<AppointmentDesign1> {
  String selectedDate = ''; // Variable to store the selected date
  String selectedTime = ''; // Variable to store the selected time

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = selectedDate.isNotEmpty && selectedTime.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        //title: Text('Help Me'),

        backgroundColor: Colors.white,
      ),
      body: Stack(
        // Wrap the Scaffold with a Stack
        children: [
          SingleChildScrollView(
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
                  const Divider(
                    height: 2,
                  ),
                  const SizedBox(height: 10),
                  const DoctorDetailView(
                      name: "Mehul Variya", description: 'Physio'),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 2,
                  ),
                  const SizedBox(height: 10),
                  DateSelector(
                    onDateSelected: (date) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 2,
                  ),
                  const SizedBox(height: 10),
                  TimeSelector(
                    onTimeSelected: (time) {
                      setState(() {
                        selectedTime = time;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 2,
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: isButtonEnabled
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PaymentDesign(),
                                ),
                              );
                            }
                          : null, // Disable the button if date or time is not selected
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isButtonEnabled
                            ? Colors.blue
                            : Colors.grey, // Change button color when disabled
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorDetailView extends StatelessWidget {
  const DoctorDetailView({
    Key? key,
    required this.name,
    required this.description,
    //required this.imagePath,
  }) : super(key: key);

  final String name;
  final String description;
  //final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 220,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: DoctorCard(
          name: "Dr. $name",
          description: "$description",
          isOpenBookBtn: false,
          imagePath: "assets/doctor.png", // Use custom image
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AppointmentDesign1(),
              ),
            );
          },
        ));
  }
}

class TimeSelector extends StatefulWidget {
  final List<String> availableTimes = List.generate(
    5,
    (index) {
      final currentTime = DateTime.now();
      final nextHour = currentTime.add(Duration(hours: index + 1));
      final formattedTime = DateFormat('h:00 a').format(nextHour);
      return formattedTime;
    },
  );

  final Function(String) onTimeSelected; // Callback for selected time

  TimeSelector({required this.onTimeSelected});

  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  String? selectedTime;

  void _handleTimeSelected(String time) {
    setState(() {
      selectedTime = time;
    });
    widget.onTimeSelected(time);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 143,
      padding: const EdgeInsets.only(top: 5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.availableTimes.length,
        itemBuilder: (BuildContext context, int index) {
          final time = widget.availableTimes[index];
          return TimeSlot(
            time: time,
            selected: selectedTime == time,
            onPressed: () {
              _handleTimeSelected(time); // Call the callback function
            },
          );
        },
      ),
    );
  }
}

class TimeSlot extends StatelessWidget {
  final String time;
  final VoidCallback onPressed;
  final bool selected;

  TimeSlot({
    required this.time,
    required this.onPressed,
    this.selected = false, // Initially not selected
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = selected ? Colors.green : Colors.blue;

    return SizedBox(
      width: 200,
      height: 50,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Keep the text color constant
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onPressed(); // Call the onPressed callback
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                selected ? 'Selected' : 'Select',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateSelector extends StatefulWidget {
  final List<String> availableDates = DateSelector.getNextFiveDays();
  final Function(String) onDateSelected;

  DateSelector({required this.onDateSelected});

  @override
  _DateSelectorState createState() => _DateSelectorState();

  static List<String> getNextFiveDays() {
    final now = DateTime.now();
    final dateList = <String>[];

    for (int i = 0; i < 5; i++) {
      final date = now.add(Duration(days: i));
      final formattedDate = DateFormat('dd/MM/yyyy').format(date);
      dateList.add(formattedDate);
    }
    return dateList;
  }
}

class _DateSelectorState extends State<DateSelector> {
  String? selectedDate;

  void _handleDateSelected(String date) {
    setState(() {
      selectedDate = date;
    });
    widget.onDateSelected(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 143,
      padding: const EdgeInsets.only(top: 5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.availableDates.length,
        itemBuilder: (BuildContext context, int index) {
          final date = widget.availableDates[index];
          return DateSlot(
            date: date,
            selected: selectedDate == date,
            onPressed: () {
              _handleDateSelected(date);
            },
          );
        },
      ),
    );
  }
}

class DateSlot extends StatelessWidget {
  final String date;
  final VoidCallback onPressed;
  final bool selected;

  DateSlot({
    required this.date,
    required this.onPressed,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = selected ? Colors.green : Colors.blue;

    return SizedBox(
      width: 200,
      height: 100,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onPressed();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                selected ? 'Selected' : 'Select',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
