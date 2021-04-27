import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

settingsTitleText(context) {
  return GoogleFonts.bungee(
    textStyle: TextStyle(
      color: Theme.of(context).accentColor,
    ),
  );
}

settingsButtonText(context) {
  return GoogleFonts.bungee(
    textStyle: TextStyle(
      fontSize: 20,
      color: Theme.of(context).accentColor,
    ),
  );
}

settingsButton(context) {
  return BoxDecoration(
    color: Colors.grey.shade400.withOpacity(0.35),
    borderRadius: BorderRadius.circular(20.0),
  );
}

accountDetailsButtonText(context) {
  return GoogleFonts.bungee(
    textStyle: TextStyle(
      fontSize: 20,
      color: Theme.of(context).accentColor,
    ),
  );
}

accountDetailsButton(context) {
  return BoxDecoration(
    color: Colors.grey.shade400.withOpacity(0.35),
    borderRadius: BorderRadius.circular(20.0),
  );
}

accountDetailsHeadingText(BuildContext context) {
  return GoogleFonts.openSans(
      textStyle: TextStyle(
    fontSize: 20,
    color: Theme.of(context).accentColor,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
  ));
}
