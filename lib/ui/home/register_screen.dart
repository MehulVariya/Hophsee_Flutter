import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../core/widget/custom_text_field.dart';
import '../../core/widget/date_picker.dart';
import '../../data/datasource/api_services.dart';
import '../../data/module/user_model.dart';
import '../dashboard/HomeScreen.dart';
import 'gender_drop_down.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ApiServiceImpl apiService = ApiServiceImpl(Dio());
  String selectedGender = 'Male';
  late File imageFile;

  DateTime _selectedDate = DateTime.now();

  void handleGenderChange(String value) {
    setState(() {
      selectedGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery
                .of(context)
                .size
                .height * 0.1,
          ),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.2,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        child: Image.asset(
                          'assets/applogo2.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                ElevatedButton(onPressed: (){
                _getImageFromUser();
                }, child: Text("Upload")),
                const SizedBox(height: 5),
                // Text fields for first name and last name
                TextFieldDesign(
                  hintText: 'Full Name',
                  labelText: 'Full Name',
                  controller: firstNameController,
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 5),

                TextFieldDesign(
                  hintText: 'Email',
                  labelText: 'Email',
                  controller: emailController,
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 5),

                TextFieldDesign(
                  hintText: 'Mobile Number',
                  labelText: 'Mobile Number',
                  controller: mobileController,
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 5),

                /*Text(_selectedDate == null //ternary expression to check if date is null
                    ? 'No date was chosen!'
                    : 'Picked Date: $_selectedDate'),*/
                CustomDatePicker(onClick: () {
                  pickDateDialog();
                }),
                const SizedBox(height: 5),

                TextFieldDesign(
                  hintText: 'Password',
                  labelText: 'Password',
                  isObscure: true,
                  controller: passwordController,
                  prefixIcon: const Icon(
                    Icons.password_sharp,
                    color: Colors.black87,
                  ),
                ),

                // Gender Dropdown
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: GenderDropdown(),
                ),

                // Registration Button
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.5,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          var userName = firstNameController.text;
                          var email = emailController.text;
                          var mobile = mobileController.text;
                          var password = passwordController.text;
                          var gender = selectedGender;
                          var dateOfBirth = DateFormat("dd-MM-yyyy").format(
                              _selectedDate);
                          var user = User(userName: userName,
                              emailId: email,
                              phoneNo: mobile,
                              password: password,
                              gender: gender.substring(0,1),
                              dateOfBirth: dateOfBirth);
                          print("user : ${user.toJson()}");
                          ApiServiceImpl(Dio())
                              .registerUser(
                          user, imageFile)
                              .then((value) {
                            // Run extra code here
                            if (value.error == 0) {
                              print("login api: $value");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            } else {
                              //not login
                            }
                          }, onError: (error) {
                            print(error);
                          });

                          /* Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Mylogin(),
                            ),
                            (route) => false,
                          );*/
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // const Divider(),

                const SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void pickDateDialog() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //which date will display when user open the picker
        firstDate: DateTime(1950),
        //what will be the previous supported year in picker
        lastDate: DateTime
            .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }

  Future<void> _getImageFromUser() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource
        .gallery); // You can also use ImageSource.camera to take a new photo.

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      // Do something with the selected image file, like displaying it or uploading it to a server.
    } else {
      // User canceled the image selection.
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
