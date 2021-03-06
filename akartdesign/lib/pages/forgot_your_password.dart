import 'package:akartdesign/pages/login_page.dart';
import 'package:akartdesign/pages/redirect_to_login_page.dart';
import 'package:akartdesign/services/custom_toast.dart';
import 'package:akartdesign/utilities/constants.dart';
import 'package:akartdesign/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotYourPassword extends StatefulWidget {
  const ForgotYourPassword({Key? key}) : super(key: key);

  @override
  _ForgotYourPasswordState createState() => _ForgotYourPasswordState();
}

class _ForgotYourPasswordState extends State<ForgotYourPassword> {
  final TextEditingController currentEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            children: [
              Container(
                width: 325,
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text("Reset Password",
                            style: TextStyle(
                                fontSize: 36.0, color: Color(0xFFffffff))),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Enter your registered email.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0, color: Color(0xFFffffff)),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: currentEmailController,
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
                            currentEmailController.text = value!;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomButton(
                          buttonColour: const Color(0xFF8BC34A),
                          horizontalPadding: 70,
                          buttonText: 'Reset',
                          onPressed: () async {
                            sendPasswordResetEmail();
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomButton(
                          buttonColour: kCDOColour,
                          horizontalPadding: 70,
                          buttonText: 'Back',
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
    );
  }

  void sendPasswordResetEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.sendPasswordResetEmail(email: currentEmailController.text);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const RedirectToLoginPage(
              textToDisplay: 'Password Email has been sent',
            ),
          ),
        );
      } on FirebaseAuthException catch (error) {
        errorText = error.code;
        if (errorText == 'user-not-found') {
          errorText = 'Incorrect Email';
        } else if (errorText == 'too-many-requests') {
          errorText =
              'Too many requests have been sent, please try again later';
        }
        // Flutter toast used to show the 'incorrect password' error
        customToast(
          msg: errorText!,
          backgroundColor: Colors.pink,
        );
      }
    }
  }
}
