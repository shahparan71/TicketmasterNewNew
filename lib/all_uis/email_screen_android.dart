import 'dart:ffi';
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
import 'package:ticket_master/utils/custom_dialog.dart';

class EmailScreenAndroid extends StatefulWidget {
  const EmailScreenAndroid({Key? key}) : super(key: key);

  @override
  _EmailScreenAndroidState createState() => _EmailScreenAndroidState();
}

class _EmailScreenAndroidState extends State<EmailScreenAndroid> {
  String? filePath;
  bool taxExeShowHide = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.offWhite2,
      body: Stack(
        children: [
          Positioned(
            top: 90,
            left: 0,
            right: 0,
            bottom: 50,
            child: Container(
              height: MediaQuery.of(context).size.height - 100,
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildColumnTopYourNew(),
                    buildContainerTopBar1(),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0XFFffffff),
                          border: Border.all(color: Colors.black26),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 3,
                              color: AppColor.officialBlue,
                            ),
                            buildContainerTopBar2(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0XFFffffff),
                                  border: Border.all(color: Colors.black26),
                                ),
                                child: Column(
                                  children: [
                                    buildContainerImageTop(),
                                    buildContainerTicketInfo(context),
                                  ],
                                ),
                              ),
                            ),
                            buildContainerOrderStatus(),
                            buildContainerSocialMedia(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: AppColor.offWhite2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(Icons.arrow_back_rounded)),
                            Container(
                                width: 140,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.archive_outlined,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Image.asset("assets/images/delete_email.png", height: 18),
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
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0, // Added left constraint for better layout control
            right: 0.0, // Added right constraint for better layout control
            child: Container(
              height: 50,
              width: double.infinity, // Use width here to avoid issues
              child: Image.asset(
                "assets/images/gmail_bottom.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildContainerOrderStatus() => Container(
        child: Column(
          children: [],
        ),
      );

  Column buildColumnTopYourNew() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            children: [
              Expanded(
                child: FutureBuilder<String>(
                  future: CommonOperation.getSharedData(AllConstant.TOP_YOUR_NEW, "Your New Orleans Pelicans vs. Utah Jazz Ticket Order"),
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    if (!snapshot.hasData) {
                      return buildContainerOrderStatus();
                    } else {
                      return GestureDetector(
                        onTap: () async {
                          String? result = await CustomInputDialog.showInputDialog(
                              context: context,
                              defaultTxt: "Your New Orleans Pelicans vs. Utah Jazz Ticket Order",
                              key: AllConstant.TOP_YOUR_NEW,
                              textInputType: TextInputType.number);
                          if (result != null) {
                            PrefUtil.preferences!.setString(
                              AllConstant.TOP_YOUR_NEW,
                              result,
                            );
                            setState(() {});
                          } else {
                            print("Dialog was canceled");
                          }
                        },
                        child: Container(
                          child: Text("${snapshot.data}",
                              style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.black)),
                        ),
                      );
                    }
                  },
                ),
              ),
              Icon(
                Icons.star,
                color: Colors.blueGrey,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2, left: 20, right: 20),
          child: Row(
            children: [
              FutureBuilder<String>(
                future: CommonOperation.getSharedData(AllConstant.TOP_YOUR_NEW_2, "2900-0558-6256-0317-9"),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (!snapshot.hasData) {
                    return buildContainerOrderStatus();
                  } else {
                    return GestureDetector(
                      onTap: () async {
                        String? result = await CustomInputDialog.showInputDialog(
                            context: context,
                            defaultTxt: "2900-0558-6256-0317-9",
                            key: AllConstant.TOP_YOUR_NEW_2,
                            textInputType: TextInputType.number);
                        if (result != null) {
                          PrefUtil.preferences!.setString(
                            AllConstant.TOP_YOUR_NEW_2,
                            result,
                          );
                          setState(() {});
                        } else {
                          print("Dialog was canceled");
                        }
                      },
                      child: Container(
                        child: Text("${snapshot.data}",
                            style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.black)),
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    //border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    child: Text("Inbox"),
                  ))
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Container buildContainerSocialMedia() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Image.asset("assets/images/social_link_android.png")],
        ),
      );

  Container buildContainerTopBar2() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logoticket.png",
              height: 20,
            ),
            //Image.asset("assets/images/logoticket.png")
          ],
        ),
      ),
    );
  }

  Container buildContainerTopBar1() {
    return Container(
      color: AppColor.gmailWhite,
      height: 65,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  height: 45,
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
                          "Ticketmaster",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        FutureBuilder<String>(
                          future: CommonOperation.getSharedData(AllConstant.EMAIL_DATE, "4 days ago"),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            if (!snapshot.hasData) {
                              return buildContainerOrderStatus();
                            } else {
                              return GestureDetector(
                                onTap: () async {
                                  String? result = await CustomInputDialog.showInputDialog(
                                      context: context, defaultTxt: "4 days ago", key: AllConstant.EMAIL_DATE, textInputType: TextInputType.number);
                                  if (result != null) {
                                    PrefUtil.preferences!.setString(
                                      AllConstant.EMAIL_DATE,
                                      result,
                                    );
                                    setState(() {});
                                  } else {
                                    print("Dialog was canceled");
                                  }
                                },
                                child: Container(
                                  child: Text(snapshot.data!,
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 14, fontFamily: "metropolis", color: AppColor.black)),
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
    );
  }

  Container buildContainerImageTop() {
    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 150,
            color: AppColor.officialBlue,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 66,
                    child: Column(
                      children: [
                        FutureBuilder<String>(
                          future: CommonOperation.getSharedData(AllConstant.GOTTICKETS, "Anisur, You Order is Confirmed"),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            if (!snapshot.hasData) {
                              return buildContainerOrderStatus();
                            } else {
                              return GestureDetector(
                                onTap: () async {
                                  String? result = await CustomInputDialog.showInputDialog(
                                      context: context,
                                      defaultTxt: "Anisur, You Order is Confirmed",
                                      key: AllConstant.GOTTICKETS,
                                      textInputType: TextInputType.number);
                                  if (result != null) {
                                    PrefUtil.preferences!.setString(
                                      AllConstant.GOTTICKETS,
                                      result,
                                    );
                                    setState(() {});
                                  } else {
                                    print("Dialog was canceled");
                                  }
                                },
                                child: Text(snapshot.data!,
                                    style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.w800, color: AppColor.white)),
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
                              return buildContainerOrderStatus();
                            } else {
                              return GestureDetector(
                                onTap: () async {
                                  String? result = await CustomInputDialog.showInputDialog(
                                      context: context,
                                      defaultTxt: "Order # 53-1325/SCS",
                                      key: AllConstant.ORDER_NUMBER,
                                      textInputType: TextInputType.number);
                                  if (result != null) {
                                    PrefUtil.preferences!.setString(
                                      AllConstant.ORDER_NUMBER,
                                      result,
                                    );
                                    setState(() {});
                                  } else {
                                    print("Dialog was canceled");
                                  }
                                },
                                child: Text(snapshot.data!,
                                    style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.white)),
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
          SizedBox(
            height: 20,
          ),
          ClipRRect(borderRadius: BorderRadius.all(Radius.circular(5)), child: Container(child: DiscoverImageAndroid()))
        ],
      ),
    );
  }

  Container buildContainerTicketInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
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
                future: CommonOperation.getSharedData(AllConstant.ORGAN_WALLEN, "New Orleans Pelicans vs. Utah Jazz"),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (!snapshot.hasData) {
                    return buildContainerOrderStatus();
                  } else {
                    return GestureDetector(
                      onTap: () async {
                        String? result = await CustomInputDialog.showInputDialog(
                            context: context,
                            defaultTxt: "New Orleans Pelicans vs. Utah Jazz",
                            key: AllConstant.ORGAN_WALLEN,
                            textInputType: TextInputType.number);
                        if (result != null) {
                          PrefUtil.preferences!.setString(
                            AllConstant.ORGAN_WALLEN,
                            result,
                          );
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
                height: 20,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: Color(0xFF103E9A),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FutureBuilder<String>(
                    future: CommonOperation.getSharedData(AllConstant.DISCOVER_DATE, "Sun . Dec 12 2921 . 7:30 PM"),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return buildContainerOrderStatus();
                      } else {
                        return GestureDetector(
                          onTap: () async {
                            String? result = await CustomInputDialog.showInputDialog(
                                context: context,
                                defaultTxt: "Sun . Dec 12 2921 . 7:30 PM",
                                key: AllConstant.DISCOVER_DATE,
                                textInputType: TextInputType.number);
                            if (result != null) {
                              PrefUtil.preferences!.setString(
                                AllConstant.DISCOVER_DATE,
                                result,
                              );
                              setState(() {});
                            } else {
                              print("Dialog was canceled");
                            }
                          },
                          child: Text(snapshot.data!,
                              style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.black)),
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
                  Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF103E9A),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FutureBuilder<String>(
                    future: CommonOperation.getSharedData(AllConstant.DISCOVER_LOCATION, "Landers Center - Southaven, MS"),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return buildContainerOrderStatus();
                      } else {
                        return GestureDetector(
                          onTap: () async {
                            String? result = await CustomInputDialog.showInputDialog(
                                context: context,
                                defaultTxt: "Landers Center - Southaven, MS",
                                key: AllConstant.DISCOVER_LOCATION,
                                textInputType: TextInputType.number);
                            if (result != null) {
                              PrefUtil.preferences!.setString(
                                AllConstant.DISCOVER_LOCATION,
                                result,
                              );
                              setState(() {});
                            } else {
                              print("Dialog was canceled");
                            }
                          },
                          child: Text(snapshot.data!,
                              style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.black)),
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
