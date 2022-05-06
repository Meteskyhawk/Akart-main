import 'package:akartdesign/pages/arch_signup_screen.dart';
import 'package:flutter/material.dart';
import '../utilities/export.dart';
import '../widgets/export.dart';
//import 'export.dart';

class InitialSignUpPage extends StatefulWidget {
  const InitialSignUpPage({Key? key}) : super(key: key);

  @override
  _InitialSignUpPageState createState() => _InitialSignUpPageState();
}

class _InitialSignUpPageState extends State<InitialSignUpPage> {
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
        child: Column(
          children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 250,
                      ),
                      const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 36.0, color: Colors.pink),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomButton(
                        buttonColour: kCDOColour,
                        horizontalPadding: 70,
                        buttonText: 'Clinic',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ClinicSignUpPage(
                                  userColour: kCDOColour,
                                ),
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomButton(
                        buttonColour: kSolicitorColour,
                        horizontalPadding: 60,
                        buttonText: 'Patients',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClinicSignUpPage(
                                userColour: kCDOColour,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomButton(
                        buttonColour: const Color(0xFFff8bd0),
                        horizontalPadding: 50,
                        buttonText: 'Back',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
