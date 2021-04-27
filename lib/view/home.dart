/*
This is a central widget which authenticates the users and asks them to complete
all their missing details before proceeding to the main application.
*/

import 'package:chat/controller/progress.dart';
import 'package:chat/model/user_data.dart';
import 'package:chat/view/login/confirmation_mail.dart';

import 'package:chat/model/user_id.dart';
import 'package:chat/model/services/auth.dart';
import 'package:chat/view/login/complete_profile.dart';
import 'package:chat/view/group_chat/group_chat.dart';
import 'package:chat/view/login/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID?>(context);
    bool isUserLoggedIn = false;
    if (user != null) {
      isUserLoggedIn = true;
    }
    if (isUserLoggedIn) {
      //the location where all the user data is saved on firebase
      final usersRef = FirebaseFirestore.instance.collection('user-info');
      return FutureBuilder(
          future: usersRef.doc(user?.id).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //fetching data
            if (!snapshot.hasData) {
              return circularProgress(context);
            } else {
              UserData? userInfo = UserData.fromDocument(snapshot.data);
              //taking the authenticated users with complete information to the next step
              if (userInfo.accountName != null) {
                return GroupChat(userInfo.accountName);
              }
              //making sure that their e-mail is verified or not. This step is only for the email+pass users.
              else {
                AuthService _auth = AuthService();
                //if someone skips the additional information form while signing up and restarts application, he/she ends up here
                if (_auth.auth.currentUser!.emailVerified) {
                  return CompleteProfile();
                } else {
                  return MailSent();
                }
              }
            }
          });
    }
    //login page for un-authorized personnel
    else {
      return SignIn();
    }
  }
}
