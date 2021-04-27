import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? id, accountName, text, time;

  Message({this.id, this.accountName, this.text, this.time});

  factory Message.fromDocument(DocumentSnapshot? doc) {
    return Message(
      id: doc?.data()?['id'],
      accountName: doc?.data()?['accountName'],
      text: doc?.data()?['text'],
      time: doc?.data()?['time'],
    );
  }
}
