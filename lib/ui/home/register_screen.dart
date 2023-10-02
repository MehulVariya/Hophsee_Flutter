import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../core/share_preference.dart';
import '../../core/utils.dart';
import '../../core/widget/custom_text_field.dart';
import '../../core/widget/date_picker.dart';
import '../../data/datasource/api_services.dart';
import '../../data/module/user_model.dart';
import 'gender_drop_down.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key});
  static const route = '/register_screen';

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
  File? imageFile; // Initialize imageFile as nullable

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
            top: MediaQuery.of(context).size.height * 0.1,
          ),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ProfileImagePicker(),
                const SizedBox(height: 20),
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
                CustomDatePicker(
                  onClick: () {
                    pickDateDialog();
                  },
                  selectedDate: _selectedDate, // Pass the selected date here
                ),
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
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: GenderDropdown(),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          var userName = firstNameController.text;
                          var email = emailController.text;
                          var mobile = mobileController.text;
                          var password = passwordController.text;
                          var gender = selectedGender;
                          var dateOfBirth =
                              DateFormat("dd-MM-yyyy").format(_selectedDate);
                          var user = User(
                            userName: userName,
                            emailId: email,
                            phoneNo: mobile,
                            password: password,
                            gender: gender.substring(0, 1),
                            dateOfBirth: dateOfBirth,
                          );
                          print("user : ${user.toJson()}");
                          apiService.registerUser(user, imageFile!)
                              .then((value) {
                            if (value.error == 0) {
                              // Successfully registered, perform login or other actions
                              loginUser(apiService, context, email, password);
                            } else {
                              showSnackbar(context, "Something went wrong");
                            }
                          }, onError: (error) {
                            print(error);
                            showSnackbar(context, "Something went wrong");
                          });
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ProfileImagePicker() {
    return GestureDetector(
      onTap: _getImageFromUser,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Stack(
            children: [
              ClipOval(
                child: imageFile != null
                    ? Image.file(
                        imageFile!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/pimage.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 24,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pickDateDialog() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  Future<void> _getImageFromUser() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
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
