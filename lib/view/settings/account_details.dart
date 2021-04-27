import 'package:chat/model/user_data.dart';
import 'package:chat/view/login/complete_profile.dart';
import 'package:chat/view/settings/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/model/user_id.dart';
import 'package:chat/controller/navigation/shortcuts.dart';
import 'package:chat/model/services/auth.dart';
import 'package:chat/model/services/database.dart';

class AccountDetails extends StatelessWidget {
  final AuthService _auth = AuthService();

  Future<bool> fileExists() async {
    var id = _auth.getCurrentUID();
    final snapShot =
        await FirebaseFirestore.instance.collection('user-info').doc(id).get();
    if (snapShot.exists) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    UserID? user = Provider.of<UserID?>(context);

    return StreamBuilder<UserData?>(
        stream: DatabaseService(uid: user?.id).info,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          String? userName = '';

          var userInfo = snapshot.data;
          print(userInfo);
          if (userInfo != null) {
            if (userInfo.userName != null) {
              userName = userInfo.userName;
              return accountOptions(context, userName);
            }
          }
          return CompleteProfile();
        });
  }

  Widget accountOptions(context, userName) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: "go back",
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: Theme.of(context).accentColor,
          ),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            goBack(context);
          },
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Text(
                'Logged in as ' + userName,
                style: accountDetailsHeadingText(context),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Column(
            children: [
              Center(
                child: GestureDetector(
                  child: Container(
                    height: 35,
                    width: 200,
                    decoration: accountDetailsButton(context),
                    child: Center(
                      child: Text(
                        "Edit Profile",
                        style: accountDetailsButtonText(context),
                      ),
                    ),
                  ),
                  onTap: () {
                    goToEditProfile(context);
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: GestureDetector(
                  child: Container(
                    height: 35,
                    width: 200,
                    decoration: accountDetailsButton(context),
                    child: Center(
                      child: Text(
                        "Sign Out",
                        style: accountDetailsButtonText(context),
                      ),
                    ),
                  ),
                  onTap: () async {
                    await _auth.signOut();
                    goToSignIn(context);
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                child: Container(
                  height: 35,
                  width: 200,
                  decoration: accountDetailsButton(context),
                  child: Center(
                    child: Text(
                      "Home",
                      style: accountDetailsButtonText(context),
                    ),
                  ),
                ),
                onTap: () => goToHome(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
