import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticket_master/utils/AppColor.dart';

class WidgetsStyle {
  static BoxDecoration BoxDecorationHomePage() {
    return BoxDecoration(
      color: AppColor.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black26, // Original shadow color
          blurRadius: 1,
          spreadRadius: 0.5,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.2), // Extra bottom shadow color
          offset: Offset(0, 2), // Shift shadow down
          blurRadius: 2, // Minimal blur to avoid affecting top corners
          spreadRadius: 0, // No spread to limit the shadow effect to the bottom
        ),
      ],
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0), bottomLeft: Radius.circular(5.0), bottomRight: Radius.circular(5.0)),
    );
  }
}
