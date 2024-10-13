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
  int indexByPage = 3;

  double iconValue = 25.0;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<int, bool> myMap = {
    1: false,
    2: false,
    3: true,
    4: false,
    5: false,
  };

  @override
  Widget build(BuildContext context) {
    iconValue = 25.0;
    print(CommonOperation.getInitIndexClick());

    return Material(
        child: Scaffold(
      key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
      drawer: buildDrawer(),
      appBar: AppBar(
        backgroundColor: AppColor.black,
        automaticallyImplyLeading: false,
        title: Row(
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
                          Icons.menu,
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
              child: Text(
                  indexByPage == 1
                      ? "Discover"
                      : indexByPage == 2
                          ? "For You"
                          : indexByPage == 3
                              ? "My Events"
                              : indexByPage == 4
                                  ? "Sell"
                                  : "Profile",
                  style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
            ),
            GestureDetector(
              onTap: () async {
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
      body: getWidget(indexByPage),
    ));
  }

  Drawer buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
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
                    "assets/images/t_blue.jpg",
                    scale: .3,
                  ),
                  height: 80,
                  width: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: FutureBuilder<String>(
                    future: CommonOperation.getSharedData(AllConstant.NAV_DRAWER_NAME, "Signed In as "),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return GestureDetector(
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
                          child: Text("${snapshot.data}",
                              style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.white)),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.location_on_outlined),
                SizedBox(
                  width: 20,
                ),
                buildContainerNavItem(AllConstant.YOUR_LOCATION, "Your Location "),
              ],
            ),
            onTap: () async {},
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.black12,
          ),
          buildListTileDrawer("Discover", 1),
          buildListTileDrawer("For You", 2),
          buildListTileDrawer("My Events", 3),
          buildListTileDrawer("Sell", 4),
          buildListTileDrawer("My Accounts", 5),
        ],
      ), // Populate the Drawer in the next step.
    );
  }

  ListTile buildListTileDrawer(String titleValue, int boolIndex) {
    return ListTile(
      tileColor: myMap[boolIndex] == true ? Colors.black12 : Colors.white,
      title: Row(
        children: [
          myMap[boolIndex] == false
              ? Image.asset(
                  'assets/images/bottom/0${boolIndex.toString()}.png',
                  width: 30,
                )
              : Image.asset(
                  'assets/images/bottom_click/${boolIndex.toString()}.png',
                  width: iconValue,
                ),
          SizedBox(
            width: 20,
          ),
          buildContainerNavItemOther("${titleValue}"),
        ],
      ),
      onTap: () async {
        for (int i = 1; i < 6; i++) {
          if (boolIndex == i) {
            myMap[i] = true;
            indexByPage = i;
          } else
            myMap[i] = false;
        }
        await Future.delayed(const Duration(milliseconds: 300));
        Navigator.pop(context);
        setState(() {});
      },
    );
  }

  Container buildContainerNavItem(String key, String defaultValue) {
    return Container(
      child: FutureBuilder<String>(
        future: CommonOperation.getSharedData(key, "${defaultValue}"),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return GestureDetector(
              onTap: () async {
                String? result = await CustomInputDialog.showInputDialog(
                  context: context,
                  defaultTxt: "${defaultValue}",
                  key: AllConstant.YOUR_LOCATION,
                );
                if (result != null) {
                  PrefUtil.preferences!.setString(AllConstant.YOUR_LOCATION, result);
                  setState(() {});
                } else {
                  print("Dialog was canceled");
                }
              },
              child: Text("${snapshot.data}",
                  style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w600, color: AppColor.black)),
            );
          }
        },
      ),
    );
  }

  Widget buildContainerNavItemOther(String titleValue) {
    return Text("${titleValue}", style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w600, color: AppColor.black));
  }

  void _navigateToScreens(int index) {
    switch (index) {
      case 0:
        return;
    }
  }

  getWidget(int index) {
    switch (index) {
      case 1:
        return Discover();
      case 3:
        return HomePage();
      case 5:
        return MyAccount();
    }

    /*index == 2
        ? HomePage()
        : index == 0
        ? Discover()
        : Container()*/
  }
}
