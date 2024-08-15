
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/utils/all_constant.dart';

double fontSizeProfileTop = 12.0;
String redAlertText =
    "Asia Pacific is facing a mounting climate and environment emergency. Global heating is intensifying storms, floods, heatwaves and wildfires, as well as slow-burning disasters like drought and food insecurity. Hundreds of millions of people are threatened by worsening climate-related disasters and rising sea levels. Many communities – including some entire nations – are set to be displaced. All this hits the most vulnerable and marginalised communities and their children hardest. Pollution of our air, land and water is killing our children and damaging the environment. Entire ecosystems are crumbling as mass species extinction accelerates. ";

class AppColor {
  static Color colorPrimary() {
    return Color(0xFFFC6011);
  }

  static Color colorGryaMyTicket = Color(0xFF4d5b66);
  static Color colorGryaBlackMyTicket = Color(0xFF425059);

  static Color colorAccent() {
    return Color(0xFF585E5F);
  }

  static Color colorTitle() {
    return Color(0xFF293032);
  }

  static Color colorShadowGray() {
    return Color(0xFFCBC9C9);
  }

  static Color colorPageBackground() {
    return Color(0xFFFFFFFF);
  }

  static Color colorTextBackground() {
    return Color(0xFFF2F2F2);
  }

  static Color colorPending() {
    return Color(0xFFF59E7E);
  }

  static Color colorDone = Color(0xFF15A64A);

  static Color colorRedButton() {
    return Color(0xFFDA291C);
  }

  static Color colorGreen() {
    return Color(0xFF194601);
  }

  static Color offWhiteGreen() {
    return Color(0xC6E7F1EA);
  }

  static Color greenDetails() {
    return Color(0xFF31895F);
  }

  static Color green() {
    return Color(0xFF45B383);
  }

  static Color offWhite() {
    return Color(0xFFF3F2EE);
  }

  static Color white() {
    return Color(0xFFFFFFFF);
  }

  static Color darkGreen() {
    return Color(0xFF194601);
  }

  static Color colorGreenLight() {
    return Color(0xFFE7F1EA);
  }

  static Color cardColor() {
    return Color(0xFFE7F1EA);
  }

  static Color lightBlue() {
    return Color(0xFFe6f5f5);
  }

  static Color offWhite2() {
    return Color(0xFFe8eef6);
  }

  static Color gmailWhite() {
    return Color(0xFFf6faff);
  }

  static Color gmailParpul() {
    return Color(0xFFba68c8);
  }

  static Color colorMain() {
    //return Color(0xFFe6f5f5);
    String? colorValue = PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.COLOR_MAIN);
    if (colorValue == null) {
      return Color(0xff026bde);
    }
    return Color(int.parse("0xFF${colorValue}"));
  }

  static Color colorSecond() {
    //return Color(0xFFe6f5f5);
    String? colorValue = PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.COLOR_SECOND);
    if (colorValue == null) {
      return Color(0xFF295fc3);
    }
    return Color(int.parse("0xFF${colorValue}"));
  }

  /*static Color blueDark() {
    //return Color(0xFFe6f5f5);
    return Color(0xFF295fc3);
  }*/

  static Color colorRed() {
    return Color(0xFFDA291C);
  }

  static Color colour1() {
    return Color(0xFFEFC84E);
  }

  static Color lightGrayBorder() {
    return Color(0xFFE6E6EC);
  }

  static Color darkGray() {
    return Color(0xFFe6e6e6);
  }

  static Color lightGreen() {
    return Color(0xFFf7fcf9);
  }

  static Color black() {
    return Color(0xFF000000);
  }

  static Color gray() {
    return Color(0xFFEBEBEB);
  }

  static Color grayLight() {
    return Color(0xFFf4f4f1);
  }

/* static MaterialColor colorPrimary() {
    return MaterialColor(0xFFFC6011, <int, Color>{
      50: Color(0xFFA4A4BF),
      100: Color(0xFFFC6011),
      200: Color(0xFFA4A4BF),
      300: Color(0xFF9191B3),
      400: Color(0xFF7F7FA6),
      500: Color(0xFF181861),
      600: Color(0xFF6D6D99),
      700: Color(0xFF5B5B8D),
      800: Color(0xFF494980),
      900: Color(0xFF181861),
    });
    //return "#FC6011";
  }

  static MaterialColor colorAccent() {
    return MaterialColor(0xFF585E5F, <int, Color>{
      50: Color(0xFFA4A4BF),
      100: Color(0xFFFC6011),
      200: Color(0xFFA4A4BF),
      300: Color(0xFF9191B3),
      400: Color(0xFF7F7FA6),
      500: Color(0xFF181861),
      600: Color(0xFF6D6D99),
      700: Color(0xFF5B5B8D),
      800: Color(0xFF494980),
      900: Color(0xFF181861),
    });
    //return "#585E5F";
  }

  static MaterialColor colorTitle() {
    return MaterialColor(0xFF293032, <int, Color>{
      50: Color(0xFFA4A4BF),
      100: Color(0xFFFC6011),
      200: Color(0xFFA4A4BF),
      300: Color(0xFF9191B3),
      400: Color(0xFF7F7FA6),
      500: Color(0xFF181861),
      600: Color(0xFF6D6D99),
      700: Color(0xFF5B5B8D),
      800: Color(0xFF494980),
      900: Color(0xFF181861),
    });
    //return "#293032";
  }

  static MaterialColor colorTextBackground() {
    return MaterialColor(0xFFF2F2F2, <int, Color>{
      50: Color(0xFFA4A4BF),
      100: Color(0xFFFC6011),
      200: Color(0xFFA4A4BF),
      300: Color(0xFF9191B3),
      400: Color(0xFF7F7FA6),
      500: Color(0xFF181861),
      600: Color(0xFF6D6D99),
      700: Color(0xFF5B5B8D),
      800: Color(0xFF494980),
      900: Color(0xFF181861),
    });
   // return "#F2F2F2";
  }

  static MaterialColor colorPending() {
    return MaterialColor(0xFFF59E7E, <int, Color>{
      50: Color(0xFFA4A4BF),
      100: Color(0xFFFC6011),
      200: Color(0xFFA4A4BF),
      300: Color(0xFF9191B3),
      400: Color(0xFF7F7FA6),
      500: Color(0xFF181861),
      600: Color(0xFF6D6D99),
      700: Color(0xFF5B5B8D),
      800: Color(0xFF494980),
      900: Color(0xFF181861),
    });
   // return "#F59E7E";
  }

  static MaterialColor colorDone() {
    return MaterialColor(0xFF15A64A, <int, Color>{
      50: Color(0xFFA4A4BF),
      100: Color(0xFFFC6011),
      200: Color(0xFFA4A4BF),
      300: Color(0xFF9191B3),
      400: Color(0xFF7F7FA6),
      500: Color(0xFF181861),
      600: Color(0xFF6D6D99),
      700: Color(0xFF5B5B8D),
      800: Color(0xFF494980),
      900: Color(0xFF181861),
    });
   // return "#15A64A";
  }

  static MaterialColor colorCritical() {
    return MaterialColor(0xFFEE2524, <int, Color>{
      50: Color(0xFFA4A4BF),
      100: Color(0xFFFC6011),
      200: Color(0xFFA4A4BF),
      300: Color(0xFF9191B3),
      400: Color(0xFF7F7FA6),
      500: Color(0xFF181861),
      600: Color(0xFF6D6D99),
      700: Color(0xFF5B5B8D),
      800: Color(0xFF494980),
      900: Color(0xFF181861),
    });
    //return "#EE2524";
  }*/
}
