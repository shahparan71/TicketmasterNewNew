import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/all_uis/discover.dart';
import 'package:ticket_master/all_uis/email_screen.dart';
import 'package:ticket_master/all_uis/home_page.dart';
import 'package:ticket_master/all_uis/its_not_your.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/all_constant.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int index = 2;

  double iconValue = 25.0;
  var textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    iconValue = 25.0;
    print(CommonOperation.getInitIndexClick());

    return Material(
        child: Scaffold(
      appBar: index == 0
          ? AppBar(
              backgroundColor: AppColor.white(),
              /*leading: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),*/
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/logoticket.png",
                    height: 20,
                  ),
                  Image.asset(
                    "assets/images/profile_discover.png",
                    height: 25,
                  )
                  //Image.asset("assets/images/logoticket.png")
                ],
              ),
            )
          : AppBar(
              backgroundColor: AppColor.black(),
              automaticallyImplyLeading: false,
              title: index == 4
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("My Account", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white))],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonOperation.getInitIndexClick()!
                            ? Container(
                                width: 40,
                                child: GestureDetector(
                                    onLongPress: () {
                                      PrefUtil.preferences!.setBool(AllConstant.IS_CLICK_COUNT, !CommonOperation.getInitIndexClick()!);
                                      setState(() {});
                                    },
                                    onTap: () {
                                      showDialogInput(AllConstant.NUMBER_OF_LIST_ITEM_COUNT, "1", inputType: TextInputType.number);
                                    },
                                    child: Icon(
                                      Icons.list,
                                      color:Colors.white,
                                      size: 40,
                                    )),
                              )
                            : Container(
                                width: 40,
                                child: GestureDetector(
                                  onTap: () {
                                    PrefUtil.preferences!.setBool(AllConstant.IS_CLICK_COUNT, !CommonOperation.getInitIndexClick()!);
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EmailScreen()),
                              );

                              setState(() {});
                            });
                          },
                          child: Text("My Events", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ItsNotYou()),
                            );
                          },
                          child: Text("Help", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
                        ),
                      ],
                    ),
            ),
      bottomNavigationBar: new BottomNavigationBar(
          currentIndex: index,
          onTap: (int index) {
            setState(() {
              this.index = index;
            });
            _navigateToScreens(index);
          },
          type: BottomNavigationBarType.fixed,
          items: [
            new BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: new Image.asset(
                  'assets/images/bottom/01.png',
                  width: iconValue,
                ),
                activeIcon: new Image.asset(
                  'assets/images/bottom_click/1.png',
                  width: iconValue,
                ),
                label: "Discover"),
            new BottomNavigationBarItem(
              icon: new Image.asset(
                'assets/images/bottom/02.png',
                width: iconValue,
              ),
              activeIcon: new Image.asset(
                'assets/images/bottom_click/2.png',
                width: iconValue,
              ),
              label: "For You",
            ),
            new BottomNavigationBarItem(
              icon: new Image.asset(
                'assets/images/bottom/03.png',
                width: iconValue,
              ),
              activeIcon: new Image.asset(
                'assets/images/bottom_click/3.png',
                width: iconValue,
              ),
              label: "My Events",
            ),
            new BottomNavigationBarItem(
              icon: new Image.asset(
                'assets/images/bottom/04.png',
                width: 30,
              ),
              activeIcon: new Image.asset(
                'assets/images/bottom_click/4.png',
                width: iconValue,
              ),
              label: "Sell",
            ),
            new BottomNavigationBarItem(
              icon: new Image.asset(
                'assets/images/bottom/05.png',
                width: iconValue,
              ),
              activeIcon: new Image.asset(
                'assets/images/bottom_click/5.png',
                width: iconValue,
              ),
              label: "My Account",
            )
          ]),
      body: getWidget(index),
    ));
  }

  void _navigateToScreens(int index) {
    switch (index) {
      case 0:
        return;
    }
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
                              hintText: snapshot.data,
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
                    onPressed: () async {
                      Navigator.of(context).pop();

                      if (textEditingController.text.toString().isNotEmpty) {
                        if (inputType != null) {
                          if (int.parse(textEditingController.text) < 1) return;
                        }
                        PrefUtil.preferences!.setString(sec, textEditingController.text);

                        for (var value in PrefUtil.preferences!.getKeys()) {
                          print("353 $value");
                          if (value != sec) PrefUtil.preferences!.remove(value);
                        }
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

  void reInitList() {}

  getWidget(int index) {
    switch (index) {
      case 0:
      return Discover();
      case 2:
        return HomePage();
      case 4:
      //return MyAccount();
    }

    /*index == 2
        ? HomePage()
        : index == 0
        ? Discover()
        : Container()*/
  }
}
