import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/all_uis/discover.dart';
import 'package:ticket_master/all_uis/email_screen.dart';
import 'package:ticket_master/all_uis/home_page.dart';
import 'package:ticket_master/all_uis/its_not_your.dart';
import 'package:ticket_master/all_uis/my_account.dart';
import 'package:ticket_master/ios/email_pages_ios.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/custom_dialog.dart';
import 'package:ticket_master/utils/widgets_util.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int index = 2;

  double iconValue = 25.0;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    iconValue = 25.0;
    print(CommonOperation.getInitIndexClick());

    return Material(
        child: Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(),
      appBar: index == 0
          ? AppBar(
              backgroundColor: AppColor.white,
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
              backgroundColor: AppColor.black,
              automaticallyImplyLeading: false,
              title: index == 4
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("My Account",
                            style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white))
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonOperation.getInitIndexClick()!
                            ? Container(
                                width: 40,
                                child: GestureDetector(
                                    onLongPress: () async {
                                      String? result = await CustomInputDialog.showInputDialog(
                                        context: context,
                                        defaultTxt: "1",
                                        key: AllConstant.NUMBER_OF_LIST_ITEM_COUNT,
                                        textInputType: TextInputType.number,
                                      );

                                      if (result != null) {
                                        if (result.isNotEmpty) {
                                          if (int.parse(result) < 1) return;

                                          PrefUtil.preferences!.setString(AllConstant.NUMBER_OF_LIST_ITEM_COUNT, result);

                                          for (var value in PrefUtil.preferences!.getKeys()) {
                                            if (value != AllConstant.NUMBER_OF_LIST_ITEM_COUNT) PrefUtil.preferences!.remove(value);
                                          }

                                          setState(() {});
                                        }
                                      } else {
                                        print("Dialog was canceled");
                                      }
                                    },
                                    onTap: () async {
                                      _scaffoldKey.currentState!.openDrawer();
                                    },
                                    child: Icon(
                                      Icons.list,
                                      color: Colors.white,
                                      size: 40,
                                    )),
                              )
                            : Container(
                                width: 40,
                                child: GestureDetector(
                                  onTap: () async {
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
                          onTap: () async {
                            setState(() {
                              if (Platform.isIOS)
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EmailScreenIOS()),
                                );
                              else
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EmailScreen()),
                                );

                              setState(() {});
                            });
                          },
                          child: Text("My Events",
                              style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ItsNotYou()),
                            );
                          },
                          child: Text("Help",
                              style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
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

  Drawer buildDrawer() {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/t.png",
                    scale: .3,
                  ),
                  height: 80,
                  width: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () async {
                      String? result = await CustomInputDialog.showInputDialog(
                        context: context,
                        defaultTxt: "Signed In as ",
                        key: AllConstant.NAV_DRAWER_NAME,
                        
                      );
                      if (result != null) {
                        PrefUtil.preferences!.setString(AllConstant.NAV_DRAWER_NAME, result);
                        setState(() {});
                      } else {
                        print("Dialog was canceled");
                      }
                    },
                    child: Text("Signed In as ",
                        style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.white)))
              ],
            ),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () async {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () async {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ), // Populate the Drawer in the next step.
    );
  }

  void _navigateToScreens(int index) {
    switch (index) {
      case 0:
        return;
    }
  }

  getWidget(int index) {
    switch (index) {
      case 0:
        return Discover();
      case 2:
        return HomePage();
      case 4:
        return MyAccount();
    }

    /*index == 2
        ? HomePage()
        : index == 0
        ? Discover()
        : Container()*/
  }
}
