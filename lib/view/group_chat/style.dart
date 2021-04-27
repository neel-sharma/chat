import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle chatTitleText(BuildContext context) {
  return GoogleFonts.firaSans(
    textStyle: TextStyle(
      fontSize: 25,
      color: Theme.of(context).accentColor,
      fontWeight: FontWeight.w500,
    ),
  );
}

TextStyle bubbleText(BuildContext context) {
  return GoogleFonts.roboto(
    textStyle: TextStyle(
      fontSize: 13,
      color: Theme.of(context).accentColor.withOpacity(0.9),
    ),
  );
}

TextStyle bubbleNameText(BuildContext context) {
  return GoogleFonts.roboto(
    textStyle: TextStyle(
      fontSize: 15,
      color: Theme.of(context).accentColor,
      fontWeight: FontWeight.w700,
    ),
  );
}

TextStyle bubbleTimeText(BuildContext context) {
  return GoogleFonts.roboto(
    textStyle: TextStyle(
      fontSize: 9,
      color: Theme.of(context).accentColor.withOpacity(0.7),
    ),
  );
}

Color bubbleColor(BuildContext context) {
  return Theme.of(context).accentColor.withOpacity(0.2);
}
