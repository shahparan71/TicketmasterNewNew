import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/utils/all_constant.dart';

double fontSizeProfileTop = 12.0;
String redAlertText =
    "Asia Pacific is facing a mounting climate and environment emergency. Global heating is intensifying storms, floods, heatwaves and wildfires, as well as slow-burning disasters like drought and food insecurity. Hundreds of millions of people are threatened by worsening climate-related disasters and rising sea levels. Many communities – including some entire nations – are set to be displaced. All this hits the most vulnerable and marginalised communities and their children hardest. Pollution of our air, land and water is killing our children and damaging the environment. Entire ecosystems are crumbling as mass species extinction accelerates. ";

class AppColor {
  static Color colorPrimary = Color(0xFFFC6011);
  static Color colorGryaMyTicket = Color(0xff000000);
  static Color officialBlue = Color(0xff024ddf);
  static Color officialBlueProfile = Color(0xff3485cd);
  static Color colorGryaBlackMyTicket = Color(0xFF000000);
  static Color colorAccent = Color(0xFF585E5F);
  static Color colorTitle = Color(0xFF293032);
  static Color colorShadowGray = Color(0xFFCBC9C9);
  static Color colorPageBackground = Color(0xFFFFFFFF);
  static Color colorTextBackground = Color(0xFFF2F2F2);
  static Color colorPending = Color(0xFFF59E7E);
  static Color colorDone = Color(0xFF15A64A);
  static Color colorRedButton = Color(0xFFDA291C);
  static Color colorGreen = Color(0xFF194601);
  static Color offWhiteGreen = Color(0xC6E7F1EA);
  static Color greenDetails = Color(0xFF31895F);
  static Color green = Color(0xFF45B383);
  static Color offWhite = Color(0xFFF3F2EE);
  static Color white = Color(0xFFFFFFFF);
  static Color darkGreen = Color(0xFF194601);
  static Color colorGreenLight = Color(0xFFE7F1EA);
  static Color cardColor = Color(0xFFE7F1EA);
  static Color lightBlue = Color(0xFFe6f5f5);
  static Color lightBlue2 = Color(0xfff0f4f4);
  static Color offWhite2 = Color(0xFFe8eef6);
  static Color gmailWhite = Color(0xFFf6faff);
  static Color gmailParpul = Color(0xFFba68c8);
  static Color gmailDarkParpul = Color(0xFF904eba);
  static Color colorRed = Color(0xFFDA291C);
  static Color colour1 = Color(0xFFEFC84E);
  static Color lightGrayBorder = Color(0xFFE6E6EC);
  static Color darkGray = Color(0xFFe6e6e6);
  static Color lightGreen = Color(0xFFf7fcf9);
  static Color black = Color(0xFF000000);
  static Color gray = Color(0xFFEBEBEB);
  static Color grayLight = Color(0xFFf4f4f1);

  static Color colorMain() {
    String? colorValue = PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.COLOR_MAIN);
    if (colorValue == null) {
      return Color(0xff000000);
    }
    return Color(int.parse("0xFF${colorValue}"));
  }

  static Color colorBlueLight() {
    String? colorValue = PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.COLOR_MAIN);
    if (colorValue == null) {
      return Color(0xff7ab1ef);
    }
    return Color(int.parse("0xFF${colorValue}"));
  }

  static Color colorSecond() {
    String? colorValue = PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.COLOR_SECOND);
    if (colorValue == null) {
      return Color(0xff000000);
    }
    return Color(int.parse("0xFF${colorValue}"));
  }
}
