import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//sign in

hintText(BuildContext context) {
  return GoogleFonts.robotoSlab(
    textStyle: TextStyle(
      color: Theme.of(context).accentColor,
    ),
  );
}

valueText(BuildContext context) {
  return GoogleFonts.robotoSlab(
    textStyle: TextStyle(
      fontSize: 18.0,
      color: Theme.of(context).accentColor,
    ),
  );
}

labelText(BuildContext context) {
  return GoogleFonts.robotoSlab(
    textStyle: TextStyle(
      color: Theme.of(context).accentColor,
      fontWeight: FontWeight.bold,
    ),
  );
}

boxStyle(BuildContext context) {
  return BoxDecoration(
    color: Colors.grey.shade400.withOpacity(0.35),
    borderRadius: BorderRadius.circular(10.0),
  );
}

loginbuttonText(BuildContext context) {
  return GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
      color: Theme.of(context).accentColor,
      letterSpacing: 1.5,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
  );
}

signInText(BuildContext context) {
  return GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
      color: Theme.of(context).accentColor,
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
  );
}

//sign up
nameHiddenText(BuildContext context) {
  return GoogleFonts.robotoSlab(
    textStyle: TextStyle(
      color: Theme.of(context).accentColor,
    ),
  );
}

nameValueText(BuildContext context) {
  return GoogleFonts.robotoSlab(
    textStyle: TextStyle(
      color: Theme.of(context).accentColor,
    ),
  );
}

nameLabelText(BuildContext context) {
  return GoogleFonts.robotoSlab(
    textStyle: TextStyle(
      color: Theme.of(context).accentColor,
      fontWeight: FontWeight.bold,
    ),
  );
}

nameBoxStyle(BuildContext context) {
  return BoxDecoration(
    color: Theme.of(context).accentColor,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );
}

emailHiddenText2(BuildContext context) {
  return GoogleFonts.robotoSlab(
    textStyle: TextStyle(
      color: Theme.of(context).accentColor,
    ),
  );
}

emailValueText2(BuildContext context) {
  return GoogleFonts.robotoSlab(
    textStyle: TextStyle(
      color: Theme.of(context).accentColor,
    ),
  );
}

iconColor(BuildContext context) {
  return Theme.of(context).accentColor;
}

genderText(BuildContext context) {
  return GoogleFonts.robotoSlab(
    textStyle: TextStyle(
      color: Theme.of(context).accentColor,
    ),
  );
}

dropText(BuildContext context) {
  return GoogleFonts.robotoSlab(
    textStyle: TextStyle(
      color: Theme.of(context).accentColor,
    ),
  );
}

dropColor(BuildContext context) {
  return Theme.of(context).primaryColor;
}

skyeFont(BuildContext context) {
  return GoogleFonts.permanentMarker(
    textStyle: TextStyle(
      fontSize: 25,
      color: Theme.of(context).accentColor,
      fontWeight: FontWeight.w100,
    ),
  );
}

headingFont(BuildContext context) {
  return GoogleFonts.roboto(
    textStyle: TextStyle(
      fontSize: 25,
      color: Theme.of(context).accentColor,
      fontWeight: FontWeight.w500,
    ),
  );
}

profilePictureText(context) {
  return GoogleFonts.roboto(
    textStyle: TextStyle(
      fontSize: 10,
      color: Theme.of(context).accentColor,
    ),
  );
}

confirmationButtonText(context) {
  return GoogleFonts.roboto(
    textStyle: TextStyle(
      fontSize: 30,
      color: Theme.of(context).accentColor.withOpacity(0.9),
      fontWeight: FontWeight.w500,
    ),
  );
}

confirmationText(context) {
  return GoogleFonts.openSans(
    textStyle: TextStyle(
      fontSize: 18,
      color: Theme.of(context).accentColor.withOpacity(0.7),
    ),
  );
}

confirmationButton(context) {
  return BoxDecoration(
    color: Colors.grey.shade400.withOpacity(0.35),
    borderRadius: BorderRadius.circular(20.0),
  );
}

completeProfileButton(context) {
  return BoxDecoration(
    color: Colors.grey.shade400.withOpacity(0.35),
    borderRadius: BorderRadius.circular(20.0),
  );
}

completeProfileText(context) {
  return GoogleFonts.roboto(
    textStyle: TextStyle(
      fontSize: 20,
      color: Theme.of(context).accentColor.withOpacity(0.9),
      fontWeight: FontWeight.w500,
    ),
  );
}
