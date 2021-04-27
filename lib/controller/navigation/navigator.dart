import 'dart:developer';

import 'package:chat/view/group_chat/group_chat.dart';
import 'package:chat/view/home.dart';
import 'package:flutter/material.dart';

import 'package:chat/view/settings/account_details.dart';
import 'package:chat/view/login/edit_profile.dart';

import 'package:chat/view/login/sign_in.dart';

import 'package:chat/view/login/sign_up.dart';
import 'package:chat/view/login/confirmation_mail.dart';

import 'package:chat/view/settings/settings.dart';
import 'package:chat/controller/navigation/shortcuts.dart';

class Path {
  static Route<dynamic> getPath(RouteSettings settings) {
    //console log rather than print to distuinguish its output from others
    log('navigated to: ' + settings.name!);
    //
    switch (settings.name) {
      case 'Home':
        return MaterialPageRoute(builder: (_) => Home());
      case 'GroupChat':
        final String time = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => GroupChat(time));
      case 'Settings':
        return MaterialPageRoute(builder: (_) => Settings());
      // Login
      //start
      case 'SignUp':
        return MaterialPageRoute(builder: (_) => SignUp());
      case 'SignIn':
        return MaterialPageRoute(builder: (_) => SignIn());
      case 'AccountDetails':
        return MaterialPageRoute(builder: (_) => AccountDetails());
      case 'ConfirmationMail':
        return MaterialPageRoute(
          builder: (_) {
            return MailSent();
          },
        );

      case 'EditProfile':
        return MaterialPageRoute(
          builder: (_) {
            return EditProfile();
          },
        );
      //end

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            tooltip: "go back",
            icon: Icon(
              Icons.arrow_back,
              size: 20,
              color: Theme.of(_).accentColor,
            ),
            color: Theme.of(_).accentColor,
            onPressed: () {
              goBack(_);
            },
          ),
        ),
        backgroundColor: Theme.of(_).primaryColor,
        body: Center(
          child: Text(
            'As the application is in alpha stage \nsome features are still under development \nstay tuned for updates.',
            style: TextStyle(color: Theme.of(_).accentColor),
          ),
        ),
      );
    });
  }
}
