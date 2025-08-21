import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:notifications/constants/theme.dart';

void showTopSnackBar(BuildContext context) {
  Flushbar(
    backgroundColor: Utils.pacificblue,
    icon: Icon(Icons.check_circle_outline, size: 28, color: Colors.white),
    shouldIconPulse: false,
    titleText: Text(
      'Success!',
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    messageText: Text(
      "🎉 Item added to cart successfully!",
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    duration: Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
    borderRadius: BorderRadius.circular(16),
    animationDuration: Duration(milliseconds: 1000),
    forwardAnimationCurve: Curves.easeOutBack,
    reverseAnimationCurve: Curves.easeIn,
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        blurRadius: 8.0,
        spreadRadius: 2.0,
        offset: Offset(0.0, 2.0),
      ),
    ],
    backgroundGradient: LinearGradient(
      colors: [Utils.maincolor, Utils.pacificblue],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    isDismissible: true,
    onTap: (flushbar) {
      flushbar.dismiss();
    },
  ).show(context);
}
