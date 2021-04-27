import 'package:flutter/material.dart';

//NAVIGATION
void goBack(BuildContext context) {
  Navigator.pop(context);
}

void goToTheme(BuildContext context) {
  Navigator.of(context).pushNamed(
    'Theme',
  );
}

void goToSettings(BuildContext context) {
  Navigator.of(context).pushNamed(
    'Settings',
  );
}

void goToHome(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    "Home",
    (r) => false,
  );
}

//LOGIN
void goToSignIn(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    "SignIn",
    (r) => true,
  );
}

void goToSignUp(BuildContext context) {
  Navigator.of(context).pushNamed(
    'SignUp',
  );
}

void goToUserDetails(BuildContext context) {
  Navigator.of(context).pushNamed(
    'UserDetails',
  );
}

void goToConfirmationMail(BuildContext context) {
  Navigator.of(context).pushNamed(
    'ConfirmationMail',
  );
}

void goToAccountDetails(BuildContext context) {
  Navigator.of(context).pushNamed(
    'AccountDetails',
  );
}

void goToNotifications(BuildContext context) {
  Navigator.of(context).pushNamed('Notifications');
}

void goToMessenger(BuildContext context) {
  Navigator.of(context).pushNamed('Messenger');
}

void goToEditProfile(BuildContext context) {
  Navigator.of(context).pushNamed(
    'EditProfile',
  );
}

void goToMailSent(context) {
  Navigator.of(context).pushNamed(
    'MailSent',
  );
}

void goToGroupChat(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    "GroupChat",
    (r) => false,
  );
}
