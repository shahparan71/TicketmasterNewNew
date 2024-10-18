import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/all_uis/QRView.dart';
import 'package:ticket_master/all_uis/bottom_sheet_view_select_tickets.dart';
import 'package:ticket_master/all_uis/carousel_withIndicator_demo_android.dart';
import 'package:ticket_master/all_uis/initial_screen.dart';
import 'package:ticket_master/maps/map_widgets.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/widgets_util.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
];

class MainLandingScreen extends StatefulWidget {
  const MainLandingScreen({Key? key}) : super(key: key);

  @override
  _MainLandingScreenState createState() => _MainLandingScreenState();
}

class _MainLandingScreenState extends State<MainLandingScreen> {
  String? filePath;
  bool showHideStatusAppBarIcon = false;
  bool isMultiline = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        // logic
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColor.colorSecond(),
          leading: Container(
            width: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        showHideStatusAppBarIcon = !showHideStatusAppBarIcon;
                      });
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showHideStatusAppBarIcon == false)
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Container(),
                      GestureDetector(
                        onTap: (){
                          setState(() {

                          });
                        },
                        child: Text("My Tickets",
                            style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
                      ),
                      Container(),
                      GestureDetector(
                          onTap: () async {
                            Future.delayed(Duration.zero, () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => InitialScreen()),
                              );
                            });
                          },
                          child: Text("Help",
                              style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white))),
                    ],
                  ),
                )
              else
                getUIControl()
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height - 50,
          child: Container(
            height: MediaQuery.of(context).size.height - 100,
            child: Stack(
              children: [
                Container(
                    height: screenHeight * 0.78,
                    child: CarouselWithIndicatorAndroid(
                      function: () {
                        setState(() {});
                      },
                    )),
                Positioned(
                  bottom: 25.0,
                  left: 0.0,
                  right: 0.0,
                  child: TransferAndSellButton(
                    function: () {
                      showMaterialModalBottomSheet(
                        isDismissible: false, // Prevents closing by tapping outside
                        enableDrag: true,
                        context: context,
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height - 450,
                          child: BottomSheetViewSelectTickets(),
                        ),
                      );
                    },
                    isButton1Enable: true,
                    isButton2Enable: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getUIControl() {
    return new Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 30.0,
        width: MediaQuery.of(context).size.width - 100,
        child: new ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                double? value = PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.VIEWPORT_VALUE);
                print(value);
                if (value == null) {
                  PrefUtil.preferences!.setDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.VIEWPORT_VALUE, 0.9);
                } else if (value == 0.9)
                  PrefUtil.preferences!.setDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.VIEWPORT_VALUE, 1);
                else
                  PrefUtil.preferences!.setDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.VIEWPORT_VALUE, 0.9);

                setState(() {});
              },
              child: PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.VIEWPORT_VALUE) == null ||
                      PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.VIEWPORT_VALUE) == 0.9
                  ? Icon(Icons.fullscreen_outlined, color: Colors.white)
                  : Icon(Icons.fullscreen_exit, color: Colors.white),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  "MT-",
                  style: TextStyle(color: Colors.white),
                )),
            GestureDetector(
                onTap: () async {
                  double? valueIncrease = PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontMain);
                  if (valueIncrease == null) {
                    setState(() {
                      PrefUtil.preferences!.setDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontMain, 17);
                    });
                  } else {
                    if (valueIncrease > 4.0) {
                      setState(() {
                        valueIncrease = valueIncrease! - 1;
                        PrefUtil.preferences!.setDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontMain, valueIncrease!);
                      });
                    }
                  }
                },
                child: Icon(Icons.remove_circle, color: Colors.white)),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
                onTap: () async {
                  double? valueIncrease = PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontMain);
                  if (valueIncrease == null) {
                    setState(() {
                      PrefUtil.preferences!.setDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontMain, 19);
                    });
                  } else {
                    setState(() {
                      valueIncrease = valueIncrease! + 1;
                      PrefUtil.preferences!.setDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontMain, valueIncrease!);
                    });
                  }
                },
                child: Icon(Icons.add_circle_outline, color: Colors.white)),
            SizedBox(
              width: 15,
            ),
            Container(alignment: Alignment.center, child: Text("ST-", style: TextStyle(color: Colors.white))),
            GestureDetector(
                onTap: () async {
                  double? valueIncrease = PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontSecond);
                  if (valueIncrease == null) {
                    setState(() {
                      PrefUtil.preferences!.setDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontSecond, 17);
                    });
                  } else {
                    if (valueIncrease > 4.0) {
                      setState(() {
                        valueIncrease = valueIncrease! - 1;
                        PrefUtil.preferences!.setDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontSecond, valueIncrease!);
                      });
                    }
                  }
                },
                child: Icon(Icons.remove_circle, color: Colors.white)),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
                onTap: () async {
                  double? valueIncrease = PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontSecond);
                  if (valueIncrease == null) {
                    setState(() {
                      PrefUtil.preferences!.setDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontSecond, 14);
                    });
                  } else {
                    setState(() {
                      valueIncrease = valueIncrease! + 1;
                      PrefUtil.preferences!.setDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontSecond, valueIncrease!);
                    });
                  }
                },
                child: Icon(Icons.add_circle_outline, color: Colors.white)),
            SizedBox(
              width: 10,
            ),
            Container(alignment: Alignment.center, child: Text("MStyle-", style: TextStyle(color: Colors.white))),
            GestureDetector(
                onTap: () async {
                  int? valueDecrease = PrefUtil.preferences!.getInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.THICK);

                  if (valueDecrease == null) {
                    setState(() {
                      PrefUtil.preferences!.setInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.THICK, 5);
                    });
                  } else {
                    if (valueDecrease > 1.0) {
                      setState(() {
                        valueDecrease = valueDecrease! - 1;
                        PrefUtil.preferences!.setInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.THICK, valueDecrease!);
                      });
                    }
                  }
                },
                child: Icon(Icons.remove_circle, color: Colors.white)),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
                onTap: () async {
                  int? valueIncrease = PrefUtil.preferences!.getInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.THICK);

                  if (valueIncrease == null) {
                    setState(() {
                      PrefUtil.preferences!.setInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.THICK, 5);
                    });
                  } else {
                    setState(() {
                      if (valueIncrease! > 8) return;
                      valueIncrease = valueIncrease! + 1;
                      PrefUtil.preferences!.setInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.THICK, valueIncrease!);
                    });
                  }
                },
                child: Icon(Icons.add_circle_outline, color: Colors.white)),
            SizedBox(
              width: 10,
            ),
            Container(alignment: Alignment.center, child: Text("SStyle-", style: TextStyle(color: Colors.white))),
            GestureDetector(
                onTap: () async {
                  int? valueDecrease = PrefUtil.preferences!.getInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.THICK_2);

                  if (valueDecrease == null) {
                    setState(() {
                      PrefUtil.preferences!.setInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.THICK_2, 5);
                    });
                  } else {
                    if (valueDecrease > 1.0) {
                      setState(() {
                        valueDecrease = valueDecrease! - 1;
                        PrefUtil.preferences!.setInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.THICK_2, valueDecrease!);
                      });
                    }
                  }
                },
                child: Icon(Icons.remove_circle, color: Colors.white)),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
                onTap: () async {
                  int? valueIncrease = PrefUtil.preferences!.getInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.THICK_2);

                  if (valueIncrease == null) {
                    setState(() {
                      PrefUtil.preferences!.setInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.THICK_2, 5);
                    });
                  } else {
                    setState(() {
                      if (valueIncrease! > 8) return;
                      valueIncrease = valueIncrease! + 1;
                      PrefUtil.preferences!.setInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.THICK_2, valueIncrease!);
                    });
                  }
                },
                child: Icon(Icons.add_circle_outline, color: Colors.white)),
            SizedBox(
              width: 10,
            ),
            Container(alignment: Alignment.center, child: Text("View-", style: TextStyle(color: Colors.white))),
            PrefUtil.preferences!.getBool(AllConstant.CURRENT_LIST_INDEX + AllConstant.IS_MULTILINE) == null ||
                    PrefUtil.preferences!.getBool(AllConstant.CURRENT_LIST_INDEX + AllConstant.IS_MULTILINE) == false
                ? GestureDetector(
                    onTap: () async {
                      setState(() {
                        bool? value = PrefUtil.preferences!.getBool(AllConstant.CURRENT_LIST_INDEX + AllConstant.IS_MULTILINE);
                        if (value == null) {
                          PrefUtil.preferences!.setBool(AllConstant.CURRENT_LIST_INDEX + AllConstant.IS_MULTILINE, true);
                        } else
                          PrefUtil.preferences!.setBool(AllConstant.CURRENT_LIST_INDEX + AllConstant.IS_MULTILINE, !value);
                      });
                    },
                    child: Icon(Icons.line_weight_sharp, color: Colors.white))
                : GestureDetector(
                    onTap: () async {
                      setState(() {
                        bool? value = PrefUtil.preferences!.getBool(AllConstant.CURRENT_LIST_INDEX + AllConstant.IS_MULTILINE);
                        PrefUtil.preferences!.setBool(AllConstant.CURRENT_LIST_INDEX + AllConstant.IS_MULTILINE, !value!);
                      });
                    },
                    child: Icon(Icons.indeterminate_check_box_outlined, color: Colors.white)),
            SizedBox(
              width: 10,
            ),
            Container(alignment: Alignment.center, child: Text("Gpay-", style: TextStyle(color: Colors.white))),
            GestureDetector(
                onTap: () async {
                  int? valueDecrease = PrefUtil.preferences!.getInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.IMAGE_SIZE);

                  if (valueDecrease == null) {
                    setState(() {
                      PrefUtil.preferences!.setInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.IMAGE_SIZE, 44);
                    });
                  } else {
                    if (valueDecrease > 1.0) {
                      setState(() {
                        valueDecrease = valueDecrease! - 1;
                        PrefUtil.preferences!.setInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.IMAGE_SIZE, valueDecrease!);
                      });
                    }
                  }
                },
                child: Icon(Icons.remove_circle, color: Colors.white)),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
                onTap: () async {
                  int? valueIncrease = PrefUtil.preferences!.getInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.IMAGE_SIZE);

                  if (valueIncrease == null) {
                    setState(() {
                      PrefUtil.preferences!.setInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.IMAGE_SIZE, 44);
                    });
                  } else {
                    setState(() {
                      valueIncrease = valueIncrease! + 1;
                      PrefUtil.preferences!.setInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.IMAGE_SIZE, valueIncrease!);
                    });
                  }
                },
                child: Icon(Icons.add_circle_outline, color: Colors.white)),
            SizedBox(
              width: 10,
            ),
            Container(alignment: Alignment.center, child: Text("Sell-", style: TextStyle(color: Colors.white))),
            GestureDetector(
                onTap: () async {
                  double? valueDecrease = PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.Sell_TRANS);

                  if (valueDecrease == null) {
                    setState(() {
                      PrefUtil.preferences!.setDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.Sell_TRANS, 0.4);
                    });
                  } else {
                    if (valueDecrease > 0.1) {
                      setState(() {
                        valueDecrease = valueDecrease! - 0.1;
                        PrefUtil.preferences!.setDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.Sell_TRANS, valueDecrease!.toDouble());
                      });
                    }
                  }
                },
                child: Icon(Icons.remove_circle, color: Colors.white)),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
                onTap: () async {
                  double? valueIncrease = PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.Sell_TRANS);

                  if (valueIncrease == null) {
                    setState(() {
                      PrefUtil.preferences!.setDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.Sell_TRANS, 0.4);
                    });
                  } else {
                    setState(() {
                      valueIncrease = valueIncrease! + 0.1;
                      if (valueIncrease! > 1.0) return;
                      PrefUtil.preferences!.setDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.Sell_TRANS, valueIncrease!);
                    });
                  }
                },
                child: Icon(Icons.add_circle_outline, color: Colors.white)),
          ],
        ));
  }
}
