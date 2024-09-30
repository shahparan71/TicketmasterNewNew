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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            bottom: 50,
            child: Container(
              height: MediaQuery.of(context).size.height - 100,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildContainerTopBar1(),
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
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
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
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(Icons.arrow_back_rounded)),
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

  Container buildContainerSocialMedia() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Color(0xFF1A1A1A),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                children: [
                  // Social media icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.facebook, color: Colors.white),
                        onPressed: () {
                          // Handle Facebook action
                        },
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Icon(Icons.install_desktop, color: Colors.white),
                        onPressed: () {
                          // Handle Instagram action
                        },
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Icon(Icons.facebook, color: Colors.white),
                        onPressed: () {
                          // Handle X (Twitter) action
                        },
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Icon(Icons.youtube_searched_for, color: Colors.white),
                        onPressed: () {
                          // Handle YouTube action
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Footer text links
                  Text(
                    'Ticketmaster   |   About   |   Terms of Use   |   Privacy   |   International',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Address text
                  Text(
                    '707 Virginia Street East, Suite 170, Charleston, WV 25301',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Copyright text
                  Text(
                    '© 2024 Ticketmaster. All rights reserved.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Container buildContainerPaymentSummary() => Container(
        height: 600,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                color: Colors.black,
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
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Total: \$13.68',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone_iphone,
                      color: Colors.purple,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        "Mobile: Your phone's your ticket. Locate your tickets in your account - or in your app. When you go mobile, your tickets will not be emailed to you or available for print.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
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
                        child: Text(
                          'Things to Know',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                      onTap: () {
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
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                      onTap: () {
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
        height: 600,
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
                height: 200,
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
                        child: Text(
                            "Important Event Info If you purchase tickets, you may receive customer service messages via email from the Chicago White Sox, including optional surveys regarding your baseball experience. Ticket holder assumes all risk of injury from balls and bats entering the stands. For more information on which seating sections have netting or screening in front of them, please visit whitesox.com/netting."),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/paper-plane.png"),
                          Text("Transfer Tickets to Friends", style: TextStyle(color: Colors.black, fontSize: 20)),
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
                                child: Text("Manage My Tickets", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16))),
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
      color: Colors.black,
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
      color: AppColor.gmailWhite(),
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
                    color: AppColor.gmailParpul(),
                    boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Center(
                      child: Text(
                    "T",
                    style: TextStyle(color: Colors.black, fontSize: 20),
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
    );
  }

  Container buildContainerImageTop() {
    return Container(
      height: 380,
      margin: EdgeInsets.symmetric(horizontal: 30),
      color: Colors.black,
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
                                onTap: () {
                                  showDialogInput(AllConstant.GOTTICKETS, "You Got the Tickets");
                                },
                                child: Text(snapshot.data!,
                                    style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.w800, color: AppColor.white())),
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
                                child: Text(snapshot.data!,
                                    style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.white())),
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
    );
  }

  Container buildContainerTicketInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      color: Colors.black,
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
                      child: Text(snapshot.data!,
                          style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w700, color: AppColor.black())),
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
                          child: Text(snapshot.data!,
                              style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.black())),
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
                          child: Text(snapshot.data!,
                              style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.black())),
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
                          child: Text(snapshot.data!,
                              style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.black())),
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
                  foregroundColor: Colors.black, // Text color
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
                  WidgetsUtil.inputBoxForAll(
                    defaultTxt,
                    sec,
                    textEditingController,
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
