import 'package:akartdesign/pages/login_page.dart';
import 'package:flutter/material.dart';

import 'package:akartdesign/widgets/export.dart';

class RedirectToLoginPage extends StatefulWidget {
  final String textToDisplay;

  const RedirectToLoginPage({
    Key? key,
    required this.textToDisplay,
  }) : super(key: key);

  @override
  _RedirectToLoginPageState createState() => _RedirectToLoginPageState();
}

class _RedirectToLoginPageState extends State<RedirectToLoginPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Center(
              child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.textToDisplay),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                buttonColour: Colors.white,
                horizontalPadding: 25,
                buttonText: 'Continue',
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                }),
          ],
        ),
      ))),
    );
  }
}
