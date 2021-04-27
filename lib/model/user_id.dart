import 'package:cloud_firestore/cloud_firestore.dart';

class UserID {
  String? id;

  UserID({this.id});

  factory UserID.fromDocument(DocumentSnapshot doc) {
    return UserID(
      id: doc.data()?['id'],
    );
  }
}
