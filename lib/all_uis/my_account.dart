import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/main.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/all_constant.dart';

class MyAccount extends StatefulWidget {
  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  var _switchNotifications = true;

  var textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<String>(
                    future: CommonOperation.getSharedData(AllConstant.DEREK, "Derek"),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () {
                            showDialogInput(AllConstant.DEREK, "Derek");
                          },
                          child: Text(
                            snapshot.data!,
                            style: TextStyle(fontSize: 24, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.white()),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 8),
                  FutureBuilder<String>(
                    future: CommonOperation.getSharedData(AllConstant.EMAIL_DEREK, "derekpsheldon@gmail.com"),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () {
                            showDialogInput(AllConstant.EMAIL_DEREK, "derekpsheldon@gmail.com");
                          },
                          child: Text(
                            snapshot.data!,
                            style: TextStyle(fontSize: 15, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: Colors.grey),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 235,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Notifications',
                        style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.black()),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      getRowWidget("assets/images/icon_my_account/message.png", 'My Notifications'),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/icon_my_account/bell.png",
                                  width: 25,
                                  height: 25,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Receive Notifications?",
                                  style: TextStyle(fontSize: 17, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.6)),
                                ),
                              ],
                            ),
                            CupertinoSwitch(
                              value: _switchNotifications,
                              activeColor: AppColor.colorSecond(),
                              onChanged: (value) {
                                setState(() {
                                  _switchNotifications = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Text(
                            'Location Setting',
                            style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: AppColor.black()),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: AppColor.colorSecond(),
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                              //boxShadow: <BoxShadow>[BoxShadow(offset: Offset(0, 0), blurRadius: 4, color: Colors.black.withOpacity(.4))],
                            ),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              child: Text(
                                "NEW!",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/icon_my_account/map.png",
                                  width: 25,
                                  height: 25,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "My Location",
                                  style: TextStyle(fontSize: 17, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: Colors.black87),
                                ),
                              ],
                            ),
                            FutureBuilder<String>(
                              future: CommonOperation.getSharedData(AllConstant.SANTA_BARBAR, "Santa Barbar"),
                              builder: (context, AsyncSnapshot<String> snapshot) {
                                if (!snapshot.hasData) {
                                  return Container();
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      showDialogInput(AllConstant.SANTA_BARBAR, "Santa Barbar");
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          snapshot.data!,
                                          style: TextStyle(fontSize: 17, fontFamily: "metropolis", fontWeight: FontWeight.w700, color: Colors.blueAccent),
                                        ),
                                        Icon(
                                          Icons.open_in_new,
                                          color: Colors.blueAccent,
                                        )
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/icon_my_account/usa_lfag.png",
                                  width: 25,
                                  height: 25,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "My Country",
                                  style: TextStyle(fontSize: 17, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: Colors.black87),
                                ),
                              ],
                            ),
                            FutureBuilder<String>(
                              future: CommonOperation.getSharedData(AllConstant.USA, "United States"),
                              builder: (context, AsyncSnapshot<String> snapshot) {
                                if (!snapshot.hasData) {
                                  return Container();
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      showDialogInput(AllConstant.USA, "United States");
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          snapshot.data!,
                                          style: TextStyle(fontSize: 17, fontFamily: "metropolis", fontWeight: FontWeight.w700, color: Colors.blueAccent),
                                        ),
                                        Icon(
                                          Icons.open_in_new,
                                          color: Colors.blueAccent,
                                        )
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/icon_my_account/tarvle.png",
                                  width: 25,
                                  height: 25,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Location Based Content",
                                  style: TextStyle(fontSize: 17, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: Colors.black87),
                                ),
                              ],
                            ),
                            CupertinoSwitch(
                              value: _switchNotifications,
                              activeColor: AppColor.colorSecond(),
                              onChanged: (value) {
                                setState(() {
                                  _switchNotifications = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Preferences',
                        style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: AppColor.black()),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      getRowWidget("assets/images/icon_my_account/favorite.png", 'My Favorites'),
                      SizedBox(
                        height: 15,
                      ),
                      getRowWidget("assets/images/icon_my_account/payment.png", 'Saved Payment Methods'),
                      SizedBox(
                        height: 15,
                      ),
                      getRowWidget("assets/images/icon_my_account/icon.png", 'Change App Icon'),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Help & Guidance',
                        style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: AppColor.black()),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      getRowWidget("assets/images/icon_my_account/help.png", 'Need Help?'),
                      SizedBox(
                        height: 15,
                      ),
                      getRowWidget("assets/images/icon_my_account/feedback.png", 'Give Us Feedback'),
                      SizedBox(
                        height: 15,
                      ),
                      getRowWidget("assets/images/icon_my_account/legal.png", 'Legal'),
                      SizedBox(
                        height: 15,
                      ),
                      getRowWidget("assets/images/icon_my_account/privacy.png", 'Privacy'),
                      SizedBox(
                        height: 40,
                      ),
                      getRowWidget("assets/images/icon_my_account/logout.png", 'Sign Out', color: Colors.red.withOpacity(0.8)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getRowWidget(String url, String s, {Color? color}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {

          print("s.containss.contain");
          print(s.contains("Out"));

          if (s.contains("Out")) {
            PrefUtil.preferences!.setInt(AllConstant.USER_LOGIN_MODE, 0);
            Future.delayed(Duration.zero, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SplashScreen()),
              );
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    "${url}",
                    width: 22,
                    height: 22,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    s,
                    style: TextStyle(fontSize: 17, fontFamily: "metropolis", fontWeight: color == null ? FontWeight.w500 : FontWeight.bold, color: color ?? Colors.black.withOpacity(0.6)),
                  ),
                ],
              ),
              Image.asset(
                "assets/images/icon_my_account/arrow.png",
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDialogInput(String sec, String defaultTxt, {TextInputType? inputType}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Color(0XFFffffff),
                      boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: FutureBuilder<String>(
                      future: CommonOperation.getSharedData(sec, defaultTxt),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          return TextField(
                            controller: textEditingController,
                            keyboardType: inputType == null ? TextInputType.text : inputType,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: snapshot.data!,
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text("OK", style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.green(),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      print("totalAnnualWestController.value");
                      print(textEditingController.text);
                      if (textEditingController.text.toString().isNotEmpty) {
                        if (inputType != null) {
                          if (int.parse(textEditingController.text) < 2 || int.parse(textEditingController.text) > 10) return;
                        }
                        PrefUtil.preferences!.setString(sec, textEditingController.text);
                        textEditingController.text = "";
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
              //myPledge: model,
            ),
          );
        });
  }
}
