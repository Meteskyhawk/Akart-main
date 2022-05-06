//import 'package:akartdesign/models/clinic_model.dart';
//import 'package:akartdesign/pages/arch_dashboard.dart';
//import 'dart:js';
//import 'package:akartdesign/models/export.dart';
//import 'package:path/path.dart' as Path;
// import 'dart:js';

//import 'dart:js';

//import 'package:akartdesign/models/clinic_model.dart';
//import 'package:akartdesign/pages/arch_dashboard.dart';
//import 'package:akartdesign/models/clinic_model.dart';
//import 'package:akartdesign/pages/arch_dashboard.dart';
//import 'package:akartdesign/pages/forgot_your_password.dart';
//import 'dart:ffi';

import 'package:akartdesign/models/clinic_model.dart';
import 'package:akartdesign/models/export.dart';
import 'package:akartdesign/pages/arch_dashboard.dart';
import 'package:akartdesign/pages/forgot_your_password.dart';
import 'package:akartdesign/pages/initial_signup_page.dart';
import 'package:akartdesign/pages/redirect_to_login_page.dart';
import 'package:akartdesign/services/custom_toast.dart';
//import 'package:akartdesign/services/auth_service.dart';
//import 'package:akartdesign/services/custom_toast.dart';
//import 'package:akartdesign/pages/redirect_to_login_page.dart';
//import 'package:akartdesign/pages/redirect_to_login_page.dart';
//import 'package:akartdesign/services/custom_toast.dart';
//import 'package:akartdesign/pages/redirect_to_login_page.dart';

//import 'package:akartdesign/services/custom_toast.dart';
import 'package:akartdesign/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

final _formKey = GlobalKey<FormState>();
final _auth = FirebaseAuth.instance;

String? errorText;
User? user;

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 325,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 200,
                          ),
                          const Text(
                            "Rxminder",
                            style: TextStyle(
                                fontSize: 36.0, color: Color(0xFFff8bd0)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (email) {
                              if (email!.isEmpty) {
                                return "Please enter your email";
                              }
                              // Email validation
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email)) {
                                return "Please enter a valid email";
                              }

                              return null;
                            },
                            onSaved: (value) {
                              emailController.text = value!;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.pink)),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: passwordController,
                            validator: (password) {
                              // RegExp regex = RegExp(r'^.{6,}$');
                              if (password!.isEmpty) {
                                return 'A Password is required to login';
                              }
                              if (!RegExp(r'^.{6,}$').hasMatch(password)) {
                                return "Enter a valid password (Min 6 chars)";
                              }
                            },
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            onSaved: (password) {
                              passwordController.text = password!;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.pink)),
                          ),
                          CustomButton(
                            buttonColour: const Color(0xFFff8bd0),
                            horizontalPadding: 70,
                            buttonText: 'Login',
                            onPressed: () {
                              loginAccount(emailController.text,
                                  passwordController.text);
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          CustomButton(
                            buttonColour: const Color(0xFFff8bd0),
                            horizontalPadding: 60,
                            buttonText: 'Sign Up',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const InitialSignUpPage(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotYourPassword(),
                                ),
                              );
                            },
                            child: const Text(
                              'Forgot Password',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.pink),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void loginAccount(String email, String password) async {
  if (_formKey.currentState!.validate()) {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((userID) => {
                user = _auth.currentUser,
                MaterialPageRoute(builder: (context) => ArchDashboard())
              });
    } on FirebaseAuthException catch (error) {
      errorText = error.code;
      if (errorText == 'user-not-found' || errorText == 'wrong-password') {
        errorText = 'Incorrect Email & Password';
      }
      // Flutter toast used to show the 'incorrect password' error
      customToast(
        msg: errorText!,
        backgroundColor: Colors.red,
      );
    }
  }
}
