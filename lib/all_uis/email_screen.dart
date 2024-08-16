import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/all_uis/ticket_details.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/widgets_util.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  String? filePath;
  var textEditingController = TextEditingController();

  bool taxExeShowHide = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: homeMain(),
      ),
    );
  }

  homeMain() {
    return Container(
      color: Color(0xFFf6faff),
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 120,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: AppColor.offWhite2(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.arrow_back_rounded),
                            Container(
                                width: 110,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset("assets/images/delete_email.png", height: 15),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(Icons.mark_email_unread_outlined),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(Icons.more_vert),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                      color: AppColor.gmailWhite(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.gmailParpul(),
                                    boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                                    border: Border.all(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "T",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  )),
                                  height: double.infinity,
                                  width: 45,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Ticketmas...",
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        FutureBuilder<String>(
                                          future: CommonOperation.getSharedData(AllConstant.EMAIL_DATE, "11/22/2023"),
                                          builder: (context, AsyncSnapshot<String> snapshot) {
                                            if (!snapshot.hasData) {
                                              return Container();
                                            } else {
                                              return GestureDetector(
                                                onTap: () async {
                                                  showDialogInput(AllConstant.EMAIL_DATE, "11/22/2023");
                                                },
                                                child: Container(
                                                  child: Text(snapshot.data!,
                                                      maxLines: 1,
                                                      textAlign: TextAlign.start,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(fontSize: 14, fontFamily: "metropolis", color: AppColor.black())),
                                                ),
                                              );
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "to me",
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.emoji_emotions_outlined),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Image.asset("assets/images/replay_email.png", height: 15),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(Icons.more_vert),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 30),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
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
              ),
            ),
            Container(
              height: 380,
              margin: EdgeInsets.symmetric(horizontal: 30),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 175,
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/images/discover_back.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Center(
                          child: Container(
                            height: 62,
                            child: Column(
                              children: [
                                FutureBuilder<String>(
                                  future: CommonOperation.getSharedData(AllConstant.GOTTICKETS, "You Got the Tickets"),
                                  builder: (context, AsyncSnapshot<String> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container();
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          showDialogInput(AllConstant.GOTTICKETS, "You Got the Tickets");
                                        },
                                        child: Text(snapshot.data!, style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.w800, color: AppColor.white())),
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
                                        onTap: () {
                                          showDialogInput(AllConstant.ORDER_NUMBER, "Order # 53-1325/SCS");
                                        },
                                        child: Text(snapshot.data!, style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.white())),
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
                  DiscoverImage()
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
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
                                onTap: () {
                                  showDialogInput(AllConstant.ORGAN_WALLEN, "Morgan Wallen");
                                },
                                child: Text(snapshot.data!, style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w700, color: AppColor.black())),
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
                                    onTap: () {
                                      showDialogInput(AllConstant.DISCOVER_DATE, "Sun . Dec 12 2921 . 7:30 PM");
                                    },
                                    child: Text(snapshot.data!, style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.black())),
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
                                    onTap: () {
                                      showDialogInput(AllConstant.DISCOVER_LOCATION, "Landers Center - Southaven, MS");
                                    },
                                    child: Text(snapshot.data!, style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.black())),
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
                            Text("Get Directions", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w700, color: Colors.blue)),
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
                                    onTap: () {
                                      showDialogInput(AllConstant.DISCOVER_EVENT, "Sec SEC 4, Row 1, Seat 11 - 12");
                                    },
                                    child: Text(snapshot.data!, style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.black())),
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
                            // rf.page.call(context, TicketDetails());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('View Mobile Ticket'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              child: Image.asset(
                "assets/images/gmail_bottom.png",
                fit: BoxFit.cover,
                height: 50.0,
                width: double.infinity,
              ),
            ),
          ],
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
                  WidgetsUtil.inputBoxForAll(defaultTxt, sec, textEditingController,),
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
                        //if (inputType != null) initSlide();
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

  void showDialogInputListed(String sec, String defaultTxt, {TextInputType? inputType}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetsUtil.inputBoxForAll(defaultTxt, sec, textEditingController, inputType: inputType),
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
                        /*if (inputType != null) {
                          if (int.parse(textEditingController.text) < -1 ||
                              int.parse(textEditingController.text) > 10)
                            return;
                        }*/
                        PrefUtil.preferences!.setString(sec, textEditingController.text);
                        textEditingController.text = "";
                        setState(() {});
                        //if (inputType != null) initSlide();
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
