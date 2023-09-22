import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/widget/custom_text_field.dart';
import '../../core/widget/date_picker.dart';
import '../../data/datasource/api_services.dart';
import 'gender_drop_down.dart';

class RegisterDesign extends StatefulWidget {
  const RegisterDesign({Key? key});

  @override
  State<RegisterDesign> createState() => _RegisterDesignState();
}

class _RegisterDesignState extends State<RegisterDesign> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ApiServiceImpl apiService = ApiServiceImpl(Dio());
  String selectedGender = 'Male';
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
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
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
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          var userName = firstNameController.text;
                          var email = emailController.text;
                          var mobile = mobileController.text;
                          var password = mobileController.text;
                          var gender = selectedGender;
                          var dateOfBirth =
                              DateFormat("dd-MM-yyyy").format(_selectedDate);

                          var isActive = 1;

                          pickDateDialog();
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

  @override
  void dispose() {
    firstNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
