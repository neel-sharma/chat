import 'package:chat/view/login/style.dart';

import 'package:flutter/material.dart';

import 'package:chat/controller/navigation/shortcuts.dart';

import 'package:chat/model/services/auth.dart';

class MailSent extends StatefulWidget {
  static const route = '/confirmationMail';

  @override
  _MailSentState createState() => _MailSentState();
}

class _MailSentState extends State<MailSent> {
  String text = 'A confirmation mail has been sent to your e-mail address. '
      'Please confirm your e-mail address by clicking on '
      'the link provided in the mail before proceeding. ';

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              text,
              style: confirmationText(context),
            ),
          ),
          SizedBox(height: 50),
          InkWell(
              child: Container(
                  width: 200,
                  decoration: confirmationButton(context),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Proceed",
                        style: confirmationButtonText(context),
                      ),
                    ),
                  )),
              onTap: () async {
                if (_auth.isEmailVerified()) {
                  goToEditProfile(context);
                }
              }),
          SizedBox(height: 25),
          InkWell(
              child: Container(
                  width: 200,
                  decoration: confirmationButton(context),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Resend",
                        style: confirmationButtonText(context),
                      ),
                    ),
                  )),
              onTap: () async {
                _auth.sendConfirmationMail();
              }),
          SizedBox(height: 25),
          InkWell(
            child: Container(
                width: 200,
                decoration: confirmationButton(context),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Sign Out",
                      style: confirmationButtonText(context),
                    ),
                  ),
                )),
            onTap: () {
              _auth.signOut();
              goToHome(context);
            },
          ),
        ],
      ),
    );
  }
}
