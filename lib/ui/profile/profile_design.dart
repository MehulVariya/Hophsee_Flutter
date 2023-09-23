import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hophseeflutter/ui/profile/help_design.dart';
import 'package:hophseeflutter/ui/profile/setting.dart';
import 'package:hophseeflutter/ui/profile/show_profile.dart';

import '../../core/constant.dart';
import '../../core/share_preference.dart';
import '../home/login_screen.dart';

class ProfileDesign extends StatefulWidget {
  const ProfileDesign({super.key});

  @override
  State<ProfileDesign> createState() => _ProfileDesignState();
}

class _ProfileDesignState extends State<ProfileDesign> {
  //var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
  final StreamController<String> _controller = StreamController<String>();

  // Getter to get the stream associated with this controller.
  Stream<String> get stream => _controller.stream;
  final StreamController<String> _image_controller = StreamController<String>();

  // Getter to get the stream associated with this controller.
  Stream<String> get image_stream => _image_controller.stream;
  @override
  Widget build(BuildContext context) {
    changeData();
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.only(top: 100),
        child: Container(
          child: Column(
            children: [
              StreamBuilder<String>(
                stream: image_stream, // Access the custom stream
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: 130,
                      height: 130,
                      child: Container(
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
                      ),
                    );
                  } else {
                    return const SizedBox(
                      child: Text(
                        "Image",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(
                height: 20,
              ),
              StreamBuilder<String>(
                stream: stream, // Access the custom stream
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      child: Text(
                        snapshot.data.toString(),
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    );
                  } else {
                    return const SizedBox(
                      child: Text(
                        "Name",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowProfileDesign(),
                        ),
                        (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),

              const SizedBox(
                height: 20,
              ),
              //menu
              Column(
                children: [
                  ProfileMenu(
                    Title: "Personal Detail",
                    icon: Icons.perm_identity,
                    onPress: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowProfileDesign(),
                          ),
                          (route) => false);
                    },
                  ),
                  // ProfileMenu(
                  //   Title: "medical Information",
                  //   icon: Icons.medical_information,
                  //   onPress: () {},
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileMenu(
                    Title: "settings",
                    icon: Icons.settings,
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ));
                    },
                  ),
                  ProfileMenu(
                    Title: "Help",
                    icon: Icons.help_outline_sharp,
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HelpMePage(),
                          ));
                    },
                  ),
                  ProfileMenu(
                    Title: "Log-Out",
                    icon: Icons.logout,
                    endIcon: false,
                    onPress: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
  void changeData() async {
    Map<String,String?> value = await Preference.getUserDetailsFromSharedPreferences();
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

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.Title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
  });

  final String Title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        height: 35,
        width: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          color: Colors.grey,
        ),
        child: Icon(
          icon,
          color: Colors.black,
        ),
      ),
      title: Text(
        Title,
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
      trailing: endIcon
          ? Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                //color: Colors.white,
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            )
          : null,
    );
  }
}
