// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hophseeflutter/ui/home/register_screen.dart';
import '../../core/widget/custom_text_field.dart';
import '../../core/widget/text_with_ink_well.dart';
import '../../data/datasource/api_services.dart';
import '../dashboard/HomeScreen.dart';
import 'forget_password_bottom_sheet.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
              ),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.asset('assets/applogo.png'),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // UserName field
            TextFieldDesign(
              hintText: 'Enter valid information here',
              labelText: 'Phone number, email or username',
              controller: emailIdController,
              prefixIcon: const Icon(
                Icons.login_rounded,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 10),

            // Password field
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

            // Login Button
            Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      ApiServiceImpl(Dio())
                          .login(
                              emailIdController.text, passwordController.text)
                          .then((value) {
                        // Run extra code here
                        if (value.error == 0) {
                          print("login api: $value");
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false,
                          );
                        } else {
                          //not login
                        }
                      }, onError: (error) {
                        print(error);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Forgot details
            TextWithInkwell(
              firstText: 'Forgot Your Login Details ?',
              secondText: 'Get Help Logging In',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const ForgotPasswordBottomSheet();
                  },
                );
              },
            ),
            const SizedBox(height: 10),

            // register or signup code
            TextWithInkwell(
              firstText: 'Doesn\'t Have An Account ?',
              secondText: 'Sign Up',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}



