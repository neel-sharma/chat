import 'package:chat/view/login/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chat/controller/navigation/shortcuts.dart';

import 'package:chat/model/services/auth.dart';

class CompleteProfile extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: InkWell(
              child: Container(
                  width: 200,
                  decoration: completeProfileButton(context),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text("Complete Profile",
                          style: completeProfileText(context)),
                    ),
                  )),
              onTap: () async {
                goToEditProfile(context);
              },
            ),
          ),
          SizedBox(height: 25),
          Center(
            child: InkWell(
              child: Container(
                  width: 200,
                  decoration: completeProfileButton(context),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                        child: Text("Sign Out",
                            style: completeProfileText(context))),
                  )),
              onTap: () async {
                await _auth.signOut();
                goToHome(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

menuFont(BuildContext context) {
  return GoogleFonts.ptSerif(
      textStyle: TextStyle(
    fontSize: 25,
    color: Theme.of(context).accentColor,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
  ));
}
