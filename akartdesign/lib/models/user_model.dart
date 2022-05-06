export 'export.dart';

class UserModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? telephoneNumber;
  String? email;
  String? userType;

  UserModel({
    this.uid,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.telephoneNumber,
    this.email,
    this.userType,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      mobileNumber: map['mobileNumber'],
      telephoneNumber: map['telephoneNumber'],
      email: map['email'],
      userType: map['userType'],
    );
  }

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
