export 'export.dart';

import 'package:akartdesign/models/user_model.dart';

class PatientsModel extends UserModel {
  String? patients;

  PatientsModel({
    pid,
    firstName,
    lastName,
    mobileNumber,
    telephoneNumber,
    email,
    userType,
    this.patients,
  }) : super(
            uid: pid,
            firstName: firstName,
            lastName: lastName,
            mobileNumber: mobileNumber,
            telephoneNumber: telephoneNumber,
            email: email,
            userType: userType);

  factory PatientsModel.fromMap(map) {
    return PatientsModel(
      pid: map['pid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      mobileNumber: map['mobileNumber'],
      telephoneNumber: map['telephoneNumber'],
      email: map['email'],
      patients: map['patients'],
      userType: map['userType'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'mobileNumber': mobileNumber,
      'telephoneNumber': telephoneNumber,
      'email': email,
      'patietns': patients,
      'userType': userType
    };
  }
}
