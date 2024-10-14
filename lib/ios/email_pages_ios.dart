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
import 'package:ticket_master/utils/custom_dialog.dart';
import 'package:ticket_master/utils/widgets_util.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

class EmailScreenIOS extends StatefulWidget {
  const EmailScreenIOS({Key? key}) : super(key: key);

  @override
  _EmailScreenIOSState createState() => _EmailScreenIOSState();
}

class _EmailScreenIOSState extends State<EmailScreenIOS> {
  String? filePath;

  bool taxExeShowHide = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Stack(
          children: [
            Positioned(
              top: 90,
              left: 0,
              right: 0,
              bottom: 150,
              child: Container(
                height: MediaQuery.of(context).size.height - 100,
                width: double.infinity,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                      FutureBuilder<String>(
                        future:
                            CommonOperation.getSharedData(AllConstant.EMAIL_YOUGOTTICKETS, "You Got Tickets To Chicago White Sox vs. The Athletics"),
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          } else {
                            return GestureDetector(
                              onTap: () async {
                                String? result = await CustomInputDialog.showInputDialog(
                                  context: context,
                                  defaultTxt: "You Got Tickets",
                                  key: AllConstant.EMAIL_YOUGOTTICKETS,
                                );
                                if (result != null) {
                                  PrefUtil.preferences!.setString(AllConstant.EMAIL_YOUGOTTICKETS, result);
                                  setState(() {});
                                } else {
                                  print("Dialog was canceled");
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                child: Text(
                                  '${snapshot.data}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/inbox.png",
                              width: 25,
                              height: 30,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Inbox',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: buildContainerTopBar1(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          height: 3,
                          color: Color(0xff103e9a),
                        ),
                      ),
                      buildContainerTopBar2(),
                      buildContainerImageTop(),
                      buildContainerTicketInfo(context),
                      buildContainerImportantInfo(),
                      buildContainerPaymentSummary(),
                      buildContainerSocialMedia()
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
                        color: AppColor.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black45,
                                  )),
                              Container(
                                  width: 110,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.more_horiz,
                                        color: Colors.black45,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Image.asset(
                                        "assets/images/delete_email_white.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Image.asset(
                                        "assets/images/archirive.png",
                                        width: 25,
                                        height: 30,
                                      ),
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
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  height: 120,
                  width: double.infinity, // Use width here to avoid issues
                  child: Image.asset(
                    "assets/images/bottom_bar_email_ios.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainerSocialMedia() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Image.asset("assets/images/social_screen.png")],
        ),
      );

  Container buildContainerPaymentSummary() => Container(
        height: 650,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment Summary',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'View Details',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 2,
                color: Colors.grey,
                width: double.infinity,
              ),
              SizedBox(height: 8),
              Text(
                'Payment Method',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'VISA — 8762',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  FutureBuilder<String>(
                    future: CommonOperation.getSharedData(AllConstant.EMAIL_DOLLAR, "13.68"),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () async {
                            String? result = await CustomInputDialog.showInputDialog(
                              context: context,
                              defaultTxt: "13.68",
                              key: AllConstant.EMAIL_DOLLAR,
                            );
                            if (result != null) {
                              PrefUtil.preferences!.setString(AllConstant.EMAIL_DOLLAR, result);
                              setState(() {});
                            } else {
                              print("Dialog was canceled");
                            }
                          },
                          child: Text(
                            'Total: \$${snapshot.data}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black26),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone_iphone,
                      color: Colors.purple,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Mobile: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                    text:
                                        "Your phone's your ticket. Locate your tickets in your account - or in your app. When you go mobile, your tickets will not be emailed to you or available for print."),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Things to Know',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      height: 70,
                      width: double.infinity,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      title: Text(
                        'Send Tickets to Your Group Ahead of Time',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black38,
                      ),
                      onTap: () async {
                        // Handle tap
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(color: Colors.grey),
                    ),
                    ListTile(
                      title: Text(
                        'Manage Your Account',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black38,
                      ),
                      onTap: () async {
                        // Handle tap
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(color: Colors.grey),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Handle Help Center navigation
                        },
                        child: Text(
                          'For more information visit our Help Center',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Container buildContainerImportantInfo() => Container(
        height: 650,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Important Information",
                  style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: Colors.black)),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 260,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                  border: Border.all(color: AppColor.colorMain()),
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Important Event Info",
                                style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: Colors.black)),
                            Text(
                                "Important Event Info If you purchase tickets, you may receive customer service messages via email from the Chicago White Sox, including optional surveys regarding your baseball experience. Ticket holder assumes all risk of injury from balls and bats entering the stands. For more information on which seating sections have netting or screening in front of them, please visit whitesox.com/netting."),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/paper-plane.png"),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Transfer Tickets to Friends", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 20)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Easily transfer your tickets on\n Ticketmaster.com or the app.", style: TextStyle(color: Colors.black, fontSize: 16)),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width - 100,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                              border: Border.all(color: AppColor.colorMain()),
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                            ),
                            child: Center(
                                child: Text("Manage My Tickets", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 16))),
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      );

  Container buildContainerTopBar2() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 30),
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
    );
  }

  Container buildContainerTopBar1() {
    return Container(
      color: AppColor.white,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Center(
                            child: Text(
                          "T",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )),
                        width: 45,
                        height: 45,
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
                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                          FutureBuilder<String>(
                            future: CommonOperation.getSharedData(AllConstant.CUSTOMER_SUPPORT_EMAIL, "customer_support@email.com"),
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              } else {
                                return GestureDetector(
                                  onTap: () async {
                                    String? result = await CustomInputDialog.showInputDialog(
                                      context: context,
                                      defaultTxt: "customer_support@email.com",
                                      key: AllConstant.CUSTOMER_SUPPORT_EMAIL,
                                    );
                                    if (result != null) {
                                      PrefUtil.preferences!.setString(AllConstant.CUSTOMER_SUPPORT_EMAIL, result);
                                      setState(() {});
                                    } else {
                                      print("Dialog was canceled");
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Custom_supp@gmail.com",
                                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w300, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                      width: 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "...",
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "To",
                          style: TextStyle(fontWeight: FontWeight.w600),
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
                                  "You",
                                  style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "josephamoabeg120@outlook.com",
                                  style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 12),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Sunday, September 15, 3:55 PM",
                                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w300, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainerImageTop() {
    return Container(
      height: 380,
      margin: EdgeInsets.symmetric(horizontal: 30),
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
                    height: 66,
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
          DiscoverImageIOS()
        ],
      ),
    );
  }

  Container buildContainerTicketInfo(BuildContext context) {
    return Container(
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
                      onTap: () async {
                        String? result = await CustomInputDialog.showInputDialog(
                          context: context,
                          defaultTxt: "Morgan Wallen",
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
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(AppColor.colorMain()),
                    backgroundColor: MaterialStateProperty.all<Color>(AppColor.colorMain()),
                    elevation: MaterialStateProperty.all(0.0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)), /*side: BorderSide(color: Colors.red)*/
                    ))),
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
                    Text('View Mobile Ticket',
                        style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w600, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
