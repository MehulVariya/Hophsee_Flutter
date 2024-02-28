import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hophseeflutter/core/extfunction.dart';
import 'package:hophseeflutter/ui/doctorpannel/doctor_dashboard.dart';
import 'package:hophseeflutter/ui/doctorpannel/doctor_home_screen.dart';
import 'package:hophseeflutter/ui/home/register_screen.dart';
import '../../core/constant.dart';
import '../../core/share_preference.dart';
import '../../core/utils.dart';
import '../../core/widget/custom_text_field.dart';
import '../../core/widget/common_label_with_tap.dart';
import '../../data/datasource/api_services.dart';
import 'forget_password_bottom_sheet.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const route = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isDoctor = false; // Track whether the user is a Doctor
  ApiServiceImpl apiService = ApiServiceImpl(Dio());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                labelText: 'Enter your email',
                controller: emailIdController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!value.isValidEmail) {
                    return 'Enter with valid email';
                  }
                  return null; // Return null if the input is valid
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null; // Return null if the input is valid
                },
                controller: passwordController,
                prefixIcon: const Icon(
                  Icons.password_sharp,
                  color: Colors.black87,
                ),
              ),

              // Checkbox for Doctor login
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: isDoctor,
                      onChanged: (value) {
                        setState(() {
                          isDoctor = value!;
                        });
                      },
                    ),
                    const Text('Login as Doctor'),
                  ],
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
                        hideKeyboard(context);
                        var email = emailIdController.text;
                        var password = passwordController.text;
                        if (_formKey.currentState!.validate()) {
                          if (isDoctor) {
                            doctorLogin(apiService, context, email, password);
                          } else {
                            loginUser(apiService, context, email, password);
                          }
                        }
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
/*              Row(children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                  child: Text("Forgot Your Login Details ?"),
                ),
                const SizedBox(
                  width: 2,
                ),
                CommonLabelWithTap(
                  text: 'Get Help Logging In',
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const ForgotPasswordBottomSheet();
                      },
                    );
                  },
                )
              ]),*/
              // Forgot details
              const SizedBox(height: 10),
              Row(children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                  child: Text("Doesn\'t Have An Account ?"),
                ),
                const SizedBox(
                  width: 2,
                ),
                CommonLabelWithTap(
                  text: 'Sign Up',
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreen.route);
                  },
                ),
              ]),
            ],
          ),
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
