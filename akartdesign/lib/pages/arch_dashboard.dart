//import 'dart:js';

import 'package:akartdesign/pages/add_medication.dart';
import 'package:akartdesign/pages/arc_edit_profile.dart';
import 'package:akartdesign/pages/redirect_to_Login_page.dart';
import 'package:akartdesign/services/auth_service.dart';
import 'package:akartdesign/widgets/settings_widget.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/export.dart';
import '../widgets/export.dart';
import '../utilities/export.dart';

// ignore: must_be_immutable
class ArchDashboard extends StatefulWidget {
  var currentUser = ClinicModel();

  ArchDashboard({
    Key? key,
  }) : super(key: key);

  @override
  _ArchDashboardState createState() => _ArchDashboardState();
}

class _ArchDashboardState extends State<ArchDashboard> {
  int _currentIndex = 0;
  late PageController _pageController;
  late String? mobileNumber = widget.currentUser.mobileNumber;
  late String? telephoneNumber = widget.currentUser.telephoneNumber;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.currentUser.userType} Dashboard'),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('patients')
                            .where('ilness', isEqualTo: widget.currentUser.uid)
                            .orderBy('dateCreated', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            final jobs = snapshot.data!.docs;
                            jobs.sort((a, b) {
                              return a['jobCompleted']
                                  .toString()
                                  .compareTo(b['jobCompleted'].toString());
                            });
                            return ListView(
                              primary: false,
                              shrinkWrap: true,
                              children: jobs.map((doc) {
                                return Card(
                                  child: ListTile(
                                    title: Text(
                                      doc.id,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    tileColor: doc['jobCompleted']
                                        ? Colors.green
                                        : Colors.red,
                                    subtitle: Text(doc['jobType'],
                                        style: TextStyle(
                                            color: Colors.grey.shade300)),
                                    trailing: const Icon(Icons.arrow_forward,
                                        color: Colors.white),
                                    onTap: () {
                                      MedicationModel;
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(doc['assignedSolicitor'])
                                          .get()
                                          .then((solicitor) {
                                        if (solicitor.data() != null) {
                                          //     archUser = MedicationModel.fromMap(
                                          //       solicitor.data());
                                        }
                                        //;
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                      // when retreiving jobs, make them populate here?
                      Container(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddMediction(
                                  currentUser: widget.currentUser,
                                ),
                              ),
                            );
                          },
                          child: const Icon(Icons.add),
                          backgroundColor: kCDOColour,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "${widget.currentUser.firstName?.capitalize()} ${widget.currentUser.lastName?.capitalize()}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Visibility(
                          visible: mobileNumber != null,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              getNumber(mobileNumber),
                              const SizedBox(
                                height: 25,
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: telephoneNumber != null,
                          child: Column(
                            children: [
                              getNumber(telephoneNumber),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${widget.currentUser.email}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        customIconButton(
                          context,
                          label: 'Edit',
                          backgroundColour: kCDOColour,
                          horizontalPadding: 35,
                          icon: Icons.edit,
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArcheditProfile(
                                  currentUser: widget.currentUser,
                                ),
                              ),
                            );
                            setState(() {
                              if (result != null) {
                                widget.currentUser = result;
                                mobileNumber = widget.currentUser.mobileNumber;
                                telephoneNumber =
                                    widget.currentUser.telephoneNumber;
                              }
                            });
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        customIconButton(
                          context,
                          label: 'Delete Account',
                          backgroundColour: Colors.red,
                          horizontalPadding: 25,
                          icon: Icons.delete_forever,
                          onPressed: () async {
                            var action = await deleteAccountDialog(context);
                            if (action != "Cancel" &&
                                action != null &&
                                action != "") {
                              var result = await AuthService()
                                  .deleteUser(widget.currentUser.email, action);
                              if (result == true) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RedirectToLoginPage(
                                              textToDisplay: 'Account Deleted',
                                            )));
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SettingsWidget(
                userColour: kCDOColour,
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomNavBar(
          controller: _pageController,
          currentIndex: _currentIndex,
          navBarItems: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: const Icon(
                Icons.apps,
              ),
              title: const Text(
                'Jobs Issued',
              ),
              activeColor: Colors.blue,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(
                Icons.people,
              ),
              title: const Text(
                'Profile',
              ),
              activeColor: Colors.purpleAccent,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(
                Icons.settings,
              ),
              title: const Text(
                'Settings',
              ),
              activeColor: Colors.grey,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
