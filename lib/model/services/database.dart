import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat/model/user_data.dart';

class DatabaseService {
  final CollectionReference accountInfo =
      FirebaseFirestore.instance.collection('user-info');

  final DateTime timestamp = DateTime.now();
  final String? uid;
  DatabaseService({this.uid});
  CollectionReference get accountDetails {
    return accountInfo;
  }

  final CollectionReference messageInfo =
      FirebaseFirestore.instance.collection('group-chat');

  Future updateUserData(
    String? id,
    String? mail,
    String? userName,
    String? uniqueName,
  ) async {
    return await accountInfo.doc(uid).set({
      'id': id ?? '',
      'mail': mail ?? '',
      'userName': userName ?? '',
      'uniqueName': uniqueName ?? '',
      'time': timestamp,
    });
  }

  Future uploadMessage(
    String? id,
    String? accountName,
    String? text,
    String? time,
  ) async {
    String? microSecond, second, minute, hour, date, month, year;

    year = time!.substring(0, 4);
    month = time.substring(5, 7);
    date = time.substring(8, 10);
    hour = time.substring(11, 13);
    minute = time.substring(14, 16);
    second = time.substring(17, 19);
    microSecond = time.substring(20, 22);

    String? timeStamp =
        year + month + date + hour + minute + second + microSecond;
    return await FirebaseFirestore.instance
        .collection('chats')
        .doc('group-chat')
        .collection(year)
        .doc(timeStamp)
        .set({
      'id': id ?? '',
      'accountName': accountName ?? '',
      'text': text ?? '',
      'time': timeStamp,
    });
  }

  UserData? _userInfoFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        id: snapshot.data()?['id'] ?? '',
        mail: snapshot.data()?['mail'] ?? '',
        userName: snapshot.data()?['userName'] ?? '',
        accountName: snapshot.data()?['uniqueName'] ?? '');
  }

  Stream<UserData?> get info {
    return accountInfo.doc(uid).snapshots().map(_userInfoFromSnapshot);
  }

  Future<Stream<QuerySnapshot>> getMessages() async {
    String time = DateTime.now().toString();
    String? year = time.substring(0, 4);
    return FirebaseFirestore.instance
        .collection("chats")
        .doc('group-chat')
        .collection(year)
        .orderBy("time", descending: true)
        .snapshots();
  }
}
