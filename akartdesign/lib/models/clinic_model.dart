import 'package:akartdesign/models/user_model.dart';

class ClinicModel extends UserModel {
  String? clinic;

  ClinicModel({
    uid,
    cilinicName,
    clinicAdress,
    telephoneNumber,
    email,
    userType,
    this.clinic,
  }) : super(
            uid: uid,
            firstName: cilinicName,
            lastName: clinicAdress,
            telephoneNumber: telephoneNumber,
            email: email,
            userType: userType);

  factory ClinicModel.fromMap(map) {
    return ClinicModel(
        uid: map['uid'],
        cilinicName: map['clinicName'],
        clinicAdress: map['ClinicAdress'],
        telephoneNumber: map['telephoneNumber'],
        email: map['email'],
        userType: map['userType']);
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
      'userType': userType
    };
  }
}
