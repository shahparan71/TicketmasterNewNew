import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticket_master/PrefUtil.dart';

import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/AppColor.dart';

class CommonOperation {
  static bool isValidMobile(String mobileNumber) {
    bool valid = false;
    if (mobileNumber != null) {
      if (mobileNumber.length == 11) {
        var code = ["011", "013", "014", "015", "016", "017", "018", "019"];
        String userCode = mobileNumber.substring(0, 3);
        for (String tempCode in code) {
          if (tempCode == userCode) {
            valid = true;
            break;
          }
        }
      } else {
        valid = false;
      }
    }
    return valid;
  }

  static Future<String> getImageData() async {
    String? value = await PrefUtil.preferences!.getString("ProfileImageURL");
    //print("value");
    //print(value);
    return value!;
  }

  static Future<File?> getImagePath(String image_path) async {
    String? value = await PrefUtil.preferences!.getString(image_path);

    if (value == null || value.isEmpty) return null;
    File imageFile = File(value);
    return imageFile;
  }

  static bool isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  static Future<String> getDonationAmount() async {
    String? DonateAmount = await PrefUtil.preferences!.getString("DonateAmount");
    return DonateAmount == null ? "\$0" : DonateAmount;
  }

  static Future<String> getTimeDelay() async {
    await Future.delayed(const Duration(microseconds: 1500), () {});
    return "ABC";
  }

  static Future<String> getSharedDataSmith(String value, String defaultValue) async {
    String? valueT = await PrefUtil.preferences!.getString(value);

    if (AllConstant.CURRENT_LIST_INDEX + AllConstant.LIVE_CON == value) {
      String? kit_smith = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.KIT_SMITH);
      kit_smith = kit_smith == null || kit_smith.isEmpty ? "Kit Smith" : kit_smith;
      return valueT == null || valueT.isEmpty ? kit_smith + " : " + defaultValue : kit_smith + " : " + valueT;
    } else
      return valueT == null || valueT.isEmpty ? defaultValue : valueT;
  }

  static Future<String> getSharedData(String value, String defaultValue, {bool? isBreak}) async {
    String? valueT = await PrefUtil.preferences!.getString(value);

    if (isBreak != null) {
      valueT = isBreak == null
          ? valueT
          : valueT == null
              ? defaultValue.replaceAll("---", '\n')
              : valueT.replaceAll("---", '\n');
    }
    return valueT == null || valueT.isEmpty ? defaultValue : valueT;
  }

  /*static Future<String> getSharedDataOnlySeat(String value,
      String defaultValue) async {
    String valueT = await PrefUtil.preferences!.getString(value);

    if (valueT == null || valueT.isEmpty) {
      return defaultValue;
    } else
      return valueT;
  }*/

  static Future<bool> getSharedDataBool(String value, bool defaultValue) async {
    bool? valueT = await PrefUtil.preferences!.getBool(value);
    return valueT == null ? defaultValue : valueT;
  }

  static Text getTitleTextJourney(String s, {int? fontSize}) {
    return Text(
      s,
      textAlign: TextAlign.center,
      style: TextStyle(color: AppColor.darkGreen(), fontFamily: "Lato", fontWeight: FontWeight.bold, fontSize: fontSize == null ? 18 : 14),
    );
  }

  static Text getTextResult(String s) {
    return Text(
      s,
      textAlign: TextAlign.center,
      style: TextStyle(color: AppColor.darkGreen(), fontFamily: "Lato", fontWeight: FontWeight.bold, fontSize: 14),
    );
  }

  static BoxDecoration getBoxDecorationLightGreen() {
    return BoxDecoration(
      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.1), blurRadius: 2, spreadRadius: 2)],
      color: AppColor.lightGreen(),
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    );
  }

  static BoxDecoration getBoxDecorationTopImage() {
    return BoxDecoration(
      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 2, spreadRadius: 2)],
      borderRadius: BorderRadius.all(Radius.circular(8)),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Colors.white.withOpacity(0.8),
          Colors.white.withOpacity(0.8),
        ],
      ),
    );
  }

  static BoxDecoration getBoxDecorationJourneyInput() {
    return BoxDecoration(
      color: Color(0XFFffffff),
      boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
      border: Border.all(color: Colors.black54),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    );
  }

  static InputDecoration getBoxDecorationInputDec() {
    return InputDecoration(
      border: InputBorder.none,
      hintText: "1",
      hintStyle: TextStyle(color: Colors.grey),
    );
  }

  static Container getTopImageJourney(String imageUrl) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.1), blurRadius: 2, spreadRadius: 2)],
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.fill,
                height: 180,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static double getDietTypeValue(String dietValue) {
    switch (dietValue) {
      case "1":
        return 3.3;
      case "2":
        return 2.5;
      case "3":
        return 1.9;
      case "4":
        return 1.7;
      case "5":
        return 1.5;
      default:
        return 1.5;
    }
  }

  static Future<int> getTicketCount() async {
    int ctr = 0;
    Set<String> keys = await PrefUtil.preferences!.getKeys();

    print(keys);

    for (var e in keys) {
      print(e);
      if (e.contains(AllConstant.CURRENT_LIST_INDEX + "circle")) {
        bool? value = await PrefUtil.preferences!.getBool(e);
        if (value!) ctr++;
      }
      //code
    }

    return ctr;
  }

  static Future<String> getTicketTitle() async {
    String ctr = "";
    /*Set<String> keys = await PrefUtil.preferences!.getKeys();
    int circleCtr = 1;
    for (var e in keys) {
      if (e.contains("card")) {
        String value = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX+AllConstant.CARD_value + circleCtr.toString());
        if (value == null) circleCtr++;
        if (value != null) ctr = ctr + "," + value.toString();
      }
    }*/

    String ticketCount = await CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.SELECTED_TICKET_COUNT, "6");

    for (int i = 0; i < int.parse(ticketCount) + 1; i++) {
      bool? value = await PrefUtil.preferences!.getBool(AllConstant.CURRENT_LIST_INDEX + AllConstant.CIRCLE_VALUE + i.toString());
      if (value != null && value == true) {
        print(value);
        String? value2 = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.CARD_value + i.toString());
        if (value2 == null)
          ctr = ctr + "," + i.toString();
        else
          ctr = ctr + "," + value2.toString();
      }
    }

    return ctr;
  }

  static FontWeight getFontWeight() {
    var value = PrefUtil.preferences!.getInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.THICK);

    value = value ?? 5;

    switch (value) {
      case 1:
        return FontWeight.w100;
      case 2:
        return FontWeight.w200;
      case 3:
        return FontWeight.w300;
      case 4:
        return FontWeight.w400;
      case 5:
        return FontWeight.w500;
      case 6:
        return FontWeight.w600;
      case 7:
        return FontWeight.w700;
      case 8:
        return FontWeight.w800;
      case 9:
        return FontWeight.w900;
      default:
        return FontWeight.w500;
    }
  }

  static FontWeight getFontWeight2() {
    int? value = PrefUtil.preferences!.getInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.THICK_2);

    value = value ?? 5;

    switch (value) {
      case 1:
        return FontWeight.w100;
      case 2:
        return FontWeight.w200;
      case 3:
        return FontWeight.w300;
      case 4:
        return FontWeight.w400;
      case 5:
        return FontWeight.w500;
      case 6:
        return FontWeight.w600;
      case 7:
        return FontWeight.w700;
      case 8:
        return FontWeight.w800;
      case 9:
        return FontWeight.w900;
      default:
        return FontWeight.w500;
    }
  }

  static bool? getInitIndexClick() {
    return PrefUtil.preferences!.getBool(AllConstant.IS_CLICK_COUNT) == null ? false : PrefUtil.preferences!.getBool(AllConstant.IS_CLICK_COUNT);
  }

  static Future<String> getSortValue(String ticketTitle) async {
    if (ticketTitle.isEmpty) return " ";
    ticketTitle = ticketTitle.substring(1, ticketTitle.length);
    List<String> lstring = ticketTitle.split(",");
    List<int> lint = lstring.map(int.parse).toList();
    lint.sort();

    print("lint88");
    print(lint);

    List<String> temp = [];

    for (int i = 0; i < lint.length; i++) {
      String v = await CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.SEAT + lint[i].toString(), lint[i].toString());
      temp.add(v);
    }
    temp.sort();
    final string = temp.reduce((value, element) => value + ',' + element);
    print("string");
    print(string);
    return string;
  }
}
