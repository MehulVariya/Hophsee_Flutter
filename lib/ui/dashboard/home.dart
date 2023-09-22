import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../doctordetails/all_doctors.dart';
import '../doctordetails/appoinment.dart';
import '../profile/profile_design.dart';
import 'doctor_card.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              HeaderDesign(
                title: "Kaushik Variya",
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
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AllDoctorDesign(),
                            ),
                            (route) => false,
                          );
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
              const DoctorHorizontal(),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderDesign extends StatelessWidget {
  const HeaderDesign({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
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
                child: Image.asset('assets/pimage.png'),
              ),
            ),
            const SizedBox(width: 16.0),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
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
                  image: AssetImage(
                      'assets/Advertisement.png'), // Replace with your image path
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllDoctorDesign(),
                        ));
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
  const DoctorHorizontal({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(0),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return DoctorCard(
            name: "Doctor $index",
            description: "Description $index",
            imagePath: "assets/doctor.png", // Use custom image
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppointmentDesign1(),
                ),
                (route) => false,
              );
            },
          );
        },
      ),
    );
  }
}
