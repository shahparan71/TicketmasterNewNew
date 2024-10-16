import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/all_uis/ticket_details.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/widgets_util.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  String? filePath;

  bool taxExeShowHide = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: homeMain(),
    );
  }

  homeMain() {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height - 100,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Container(
              height: 400,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/images/discover_back.png",
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                        Center(
                          child: Container(
                            height: 70,
                            child: Column(
                              children: [
                                FutureBuilder<String>(
                                  future: CommonOperation.getSharedData(AllConstant.GOTTICKETS, "You Got the Tickets"),
                                  builder: (context, AsyncSnapshot<String> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container();
                                    } else {
                                      return GestureDetector(
                                        onTap: () async {
                                          String? result = await CustomInputDialog.showInputDialog(
                                            context: context,
                                            defaultTxt: "You Got the Tickets",
                                            key: AllConstant.GOTTICKETS,
                                          );
                                          if (result != null) {
                                            PrefUtil.preferences!.setString(AllConstant.GOTTICKETS, result);
                                            setState(() {});
                                          } else {
                                            print("Dialog was canceled");
                                          }
                                        },
                                        child: Text(snapshot.data!,
                                            style: TextStyle(
                                                fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.w800, color: AppColor.white)),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                FutureBuilder<String>(
                                  future: CommonOperation.getSharedData(AllConstant.ORDER_NUMBER, "Order # 53-1325/SCS"),
                                  builder: (context, AsyncSnapshot<String> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container();
                                    } else {
                                      return GestureDetector(
                                        onTap: () async {
                                          String? result = await CustomInputDialog.showInputDialog(
                                            context: context,
                                            defaultTxt: "Order # 53-1325/SCS",
                                            key: AllConstant.ORDER_NUMBER,
                                          );
                                          if (result != null) {
                                            PrefUtil.preferences!.setString(AllConstant.ORDER_NUMBER, result);
                                            setState(() {});
                                          } else {
                                            print("Dialog was canceled");
                                          }
                                        },
                                        child: Text(snapshot.data!,
                                            style: TextStyle(
                                                fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.white)),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  DiscoverImageAndroid()
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        FutureBuilder<String>(
                          future: CommonOperation.getSharedData(AllConstant.ORGAN_WALLEN, "Morgan Wallen"),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              return GestureDetector(
                                onTap: () async {
                                  String? result = await CustomInputDialog.showInputDialog(
                                    context: context,
                                    defaultTxt: "Morgan Wallen",
                                    key: AllConstant.ORGAN_WALLEN,
                                  );
                                  if (result != null) {
                                    PrefUtil.preferences!.setString(AllConstant.ORGAN_WALLEN, result);
                                    setState(() {});
                                  } else {
                                    print("Dialog was canceled");
                                  }
                                },
                                child: Text(snapshot.data!,
                                    style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w700, color: AppColor.black)),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/date.png",
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            FutureBuilder<String>(
                              future: CommonOperation.getSharedData(AllConstant.DISCOVER_DATE, "Sun . Dec 12 2921 . 7:30 PM"),
                              builder: (context, AsyncSnapshot<String> snapshot) {
                                if (!snapshot.hasData) {
                                  return Container();
                                } else {
                                  return GestureDetector(
                                    onTap: () async {
                                      String? result = await CustomInputDialog.showInputDialog(
                                        context: context,
                                        defaultTxt: "Sun . Dec 12 2921 . 7:30 PM",
                                        key: AllConstant.DISCOVER_DATE,
                                      );
                                      if (result != null) {
                                        PrefUtil.preferences!.setString(AllConstant.DISCOVER_DATE, result);
                                        setState(() {});
                                      } else {
                                        print("Dialog was canceled");
                                      }

                                    },
                                    child: Text(snapshot.data!,
                                        style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.black)),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/location.png",
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            FutureBuilder<String>(
                              future: CommonOperation.getSharedData(AllConstant.DISCOVER_LOCATION, "Landers Center - Southaven, MS"),
                              builder: (context, AsyncSnapshot<String> snapshot) {
                                if (!snapshot.hasData) {
                                  return Container();
                                } else {
                                  return GestureDetector(
                                    onTap: () async {
                                      String? result = await CustomInputDialog.showInputDialog(
                                        context: context,
                                        defaultTxt: "Landers Center - Southaven, MS",
                                        key: AllConstant.DISCOVER_LOCATION,
                                      );
                                      if (result != null) {
                                        PrefUtil.preferences!.setString(AllConstant.DISCOVER_LOCATION, result);
                                        setState(() {});
                                      } else {
                                        print("Dialog was canceled");
                                      }
                                    },
                                    child: Text(snapshot.data!,
                                        style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.black)),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.point_of_sale,
                              color: Colors.transparent,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Get Directions",
                                style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w700, color: Colors.blue)),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/ticketN.png",
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            FutureBuilder<String>(
                              future: CommonOperation.getSharedData(AllConstant.DISCOVER_EVENT, "Sec SEC 4, Row 1, Seat 11 - 12"),
                              builder: (context, AsyncSnapshot<String> snapshot) {
                                if (!snapshot.hasData) {
                                  return Container();
                                } else {
                                  return GestureDetector(
                                    onTap: () async {
                                      String? result = await CustomInputDialog.showInputDialog(
                                        context: context,
                                        defaultTxt: "Sec SEC 4, Row 1, Seat 11 - 12",
                                        key: AllConstant.DISCOVER_EVENT,
                                      );
                                      if (result != null) {
                                        PrefUtil.preferences!.setString(AllConstant.DISCOVER_EVENT, result);
                                        setState(() {});
                                      } else {
                                        print("Dialog was canceled");
                                      }
                                    },
                                    child: Text(snapshot.data!,
                                        style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.black)),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            elevation: 0.0,
                            backgroundColor: AppColor.colorMain(), // Background color
                            foregroundColor: Colors.white, // Text color
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TicketDetails()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('View Mobile Ticket'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
