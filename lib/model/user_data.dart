import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? id;
  String? mail;
  String? pass;
  String? userName;
  String? dateOfBirth;
  String? gender;
  String? accountName;

  UserData({
    this.id,
    this.mail,
    this.pass,
    this.userName,
    this.accountName,
  });

  factory UserData.fromDocument(DocumentSnapshot? doc) {
    return UserData(
      id: doc?.data()?['id'],
      mail: doc?.data()?['mail'],
      pass: doc?.data()?['pass'],
      userName: doc?.data()?['userName'],
      accountName: doc?.data()?['uniqueName'],
    );
  }
}
