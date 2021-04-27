import 'package:chat/model/user_id.dart';
import 'package:chat/view/settings/style.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/controller/navigation/shortcuts.dart';

class Settings extends StatelessWidget {
  static const IconData settings =
      IconData(0xe3c7, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    bool isUserLoggedIn = false;
    UserID? user = Provider.of<UserID?>(context);
    if (user != null) isUserLoggedIn = true;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SETTINGS',
          style: settingsTitleText(context),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: GestureDetector(
              child: Container(
                width: 200,
                height: 40,
                decoration: settingsButton(context),
                child: Center(
                  child: Text(
                    "Accounts",
                    style: settingsButtonText(context),
                  ),
                ),
              ),
              onTap: () {
                if (!isUserLoggedIn) {
                  goToSignIn(context);
                } else {
                  goToAccountDetails(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
