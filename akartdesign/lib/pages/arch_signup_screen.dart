import 'package:akartdesign/models/clinic_model.dart';
import 'package:akartdesign/pages/redirect_to_login_page.dart';
import 'package:akartdesign/services/custom_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/export.dart';

class ClinicSignUpPage extends StatefulWidget {
  final Color userColour;

  const ClinicSignUpPage({
    Key? key,
    required this.userColour,
  }) : super(key: key);
  @override
  _ClinicSignUpPage createState() => _ClinicSignUpPage();
}

class _ClinicSignUpPage extends State<ClinicSignUpPage> {
  String _clinic = ' clinic';
  bool isChecked = false;
  final userType = 'clinic';

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController telephoneNumberController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firmNameController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: widget.userColour),
          onPressed: () => Navigator.pop(context, false),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(
                  'https://media-exp1.licdn.com/dms/image/C4D35AQEm-gRuzkIMTw/profile-framedphoto-shrink_800_800/0/1612996253510?e=1651770000&v=beta&t=xrpqlDC96FlczPsp2xkFY0YVyWFyNwmgDSoFqzUj0d4'),
              backgroundColor: Colors.pink,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.pink,
                border: Border.all(
                  color: widget.userColour,
                  width: 5,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: firstNameController,
                        validator: (firstName) {
                          if (firstName!.isEmpty) {
                            return 'Clinic name is required for signup';
                          }

                          return null;
                        },
                        onSaved: (firstName) {
                          firstNameController.text = firstName!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Clinic Name',
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: lastNameController,
                        validator: (lastName) {
                          if (lastName!.isEmpty) {
                            return 'Clinic Adress is required for signup';
                          }

                          return null;
                        },
                        onSaved: (lastName) {
                          lastNameController.text = lastName!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Adress',
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: mobileNumberController,
                        validator: (mobileNum) {
                          if (mobileNum!.isEmpty) {
                            return 'A mobile number is required';
                          }
                          if (!RegExp(r'^.{10,}$').hasMatch(mobileNum)) {
                            return "Mobile Number must be at least 10-digits";
                          }

                          return null;
                        },
                        onSaved: (mobileNum) {
                          mobileNumberController.text = mobileNum!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Mobile Number',
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: telephoneNumberController,
                        validator: (teleNum) {
                          if (teleNum!.isEmpty) return null;
                          if (!RegExp(r'^.{10,}$').hasMatch(teleNum)) {
                            return "Telephone Number must be at least 10-digits";
                          }
                        },
                        onSaved: (teleNum) {
                          telephoneNumberController.text = teleNum!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Telephone Number',
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 8,
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
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: confirmEmailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) {
                          if (emailController.text != email) {
                            return "Email does not match";
                          }

                          return null;
                        },
                        onSaved: (value) {
                          confirmEmailController.text = value!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Confirm Email',
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 8,
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
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: confirmPasswordController,
                        validator: (password) {
                          // RegExp regex = RegExp(r'^.{6,}$');
                          if (passwordController.text != password) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onSaved: (password) {
                          confirmPasswordController.text = password!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CheckboxListTile(
                        title: const Text('I am a clinic doctor'),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value as bool;
                          });
                        },
                      ),
                      Visibility(
                        visible: !isChecked,
                        child: DropdownButton<String>(
                          hint: const Text(
                            "Select a Doctor",
                          ),
                          items: <String>['clinic 1', 'clinic 2', 'clinic 3']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _clinic = value as String;
                            });
                          },
                        ),
                      ),
                      TextFormField(
                        controller: experienceController,
                        validator: (experience) {
                          if (experience!.isEmpty) {
                            return 'Please enter your amount of experience';
                          }
                        },
                        onSaved: (experience) {
                          experienceController.text = experience!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Years of experience',
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomButton(
              buttonColour: widget.userColour,
              horizontalPadding: 25,
              buttonText: 'Submit',
              onPressed: () {
                signup(emailController.text, passwordController.text);
              },
            )
          ],
        ),
      ),
    );
  }

  void signup(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {createUser()});
      } on FirebaseAuthException catch (error) {
        errorText = error.code;
        if (errorText == 'email-already-in-use') {
          errorText = 'User with this Email already exists';
        }
        customToast(
          msg: errorText!,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  createUser() async {
    ClinicModel userModel = ClinicModel();
    User? user = _auth.currentUser;

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Entering new CDO user fields
    userModel.uid = user!.uid;
    userModel.firstName = firstNameController.text;
    userModel.lastName = lastNameController.text;
    userModel.mobileNumber = mobileNumberController.text;
    userModel.telephoneNumber = telephoneNumberController.text;
    userModel.email = user.email;
    userModel.clinic = userType;
    if (!isChecked) {
      userModel.clinic = _clinic;
    }
    userModel.userType = userType;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    user.sendEmailVerification();

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => RedirectToLoginPage(
              textToDisplay:
                  'An Email has been sent to ${user.email} please verify',
            )));
  }
}
