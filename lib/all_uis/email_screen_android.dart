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
import 'package:ticket_master/utils/future_stateful_widget.dart';
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
              color:AppColor.offWhite2,
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
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
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "If this email is not displaying correctly, ",
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  "view in browser version.",
                                  style: TextStyle(fontSize: 10, color: Colors.blueAccent),
                                ),
                              ],
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
                            SizedBox(
                              height: 20,
                            ),
                            Text("THIS EMAIL CANNOT BE USED FOR ENTRY ",
                                style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.black)),
                            SizedBox(
                              height: 20,
                            ),
                            getYourOrderDetilas(),
                            getYourOrderAmount(),
                            SizedBox(
                              height: 20,
                            ),
                            Image.asset("assets/images/social_link_android.png"),
                            Container(height: 10,color: AppColor.offWhite_bottom,),
                            Image.asset(
                              "assets/images/email_reply.png",
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                              height: 100,
                            )
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
                                  print("object3535");
                                },
                                child: Container(

                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.arrow_back_rounded),
                                    ))),
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
                "assets/images/email_bottom.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildContainerOrderStatus() => Container(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                //border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    //blue_ticket.png
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/blue_ticket.png",
                          width: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Order Status: ",
                            style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.black)),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Confirmed",
                            style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.w600, color: AppColor.gmailDarkParpul)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    FutureBuilder<String>(
                      future: CommonOperation.getSharedData(AllConstant.CONFIRMED_ORDER_DATE, "Jan 22, 2025"),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          return GestureDetector(
                            onTap: () async {
                              String? result = await CustomInputDialog.showInputDialog(
                                context: context,
                                defaultTxt: "Jan 22, 2025",
                                key: AllConstant.CONFIRMED_ORDER_DATE,
                              );
                              if (result != null) {
                                PrefUtil.preferences!.setString(
                                  AllConstant.CONFIRMED_ORDER_DATE,
                                  result,
                                );
                                setState(() {});
                              } else {
                                print("Dialog was canceled");
                              }
                            },
                            child: Text("Your order is confirmed. You will be notified about your ticket delivery by ${snapshot.data}",
                                style: TextStyle(fontSize: 12, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.black)),
                          );
                        }
                      },
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        "When your tickets are ready to be viewed, you'll receive an"
                        " email notification with details about accepting and accessing "
                        "your tickets. Don't miss this important email that will be delivered "
                        "to you prior to the event!",
                        style: TextStyle(fontSize: 12, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.black))
                  ],
                ),
              ),
            ),
          ),
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
                child: CustomBuilderWidget(
                    keyValue: AllConstant.TOP_YOUR_NEW,
                    defaultValue: "Your New Orleans Pelicans vs. Utah Jazz Ticket Order",
                    textStyle: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.black)),
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
              CustomBuilderWidget(
                  keyValue: AllConstant.TOP_YOUR_NEW_2,
                  defaultValue: "2900-0558-6256-0317-9",
                  textStyle: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.black)),
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
      color: AppColor.offWhite2,
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
                        CustomBuilderWidget(
                            keyValue: AllConstant.EMAIL_DATE,
                            defaultValue: "4 days ago",
                            textStyle: TextStyle(fontSize: 14, fontFamily: "metropolis", color: AppColor.black)),
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
                        CustomBuilderWidget(
                            keyValue: AllConstant.GOTTICKETS,
                            defaultValue: "Anisur, You Order is Confirmed",
                            textStyle: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.w800, color: AppColor.white)),
                        SizedBox(
                          height: 20,
                        ),
                        CustomBuilderWidget(
                            keyValue: AllConstant.ORDER_NUMBER,
                            defaultValue: "Order # 53-1325/SCS",
                            textStyle: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.white)),
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
              CustomBuilderWidget(
                  keyValue: AllConstant.ORGAN_WALLEN,
                  defaultValue: "New Orleans Pelicans vs. Utah Jazz",
                  textStyle: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w700, color: AppColor.black)),
              SizedBox(
                height: 20,
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
                  CustomBuilderWidget(
                    keyValue: AllConstant.DISCOVER_LOCATION,
                    defaultValue: "Landers Center - Southaven, MS",
                    textStyle: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.black),
                  ),
                ],
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
                  CustomBuilderWidget(
                    keyValue: AllConstant.DISCOVER_DATE,
                    defaultValue: "Sun . Dec 12 2921 . 7:30 PM",
                    textStyle: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.black),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getYourOrderDetilas() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFffffff),
          border: Border.all(color: Colors.black26),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text("Your Order", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w700, color: AppColor.black)),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/blue_ticket.png",
                    width: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomBuilderWidget(
                    keyValue: AllConstant.EMAIL_2X,
                    defaultValue: "2x",
                    textStyle: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.black),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Resale tickets",
                      style: TextStyle(fontSize: 12, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.black)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "View Order Details",
                      style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w500 ?? FontWeight.normal, color: Colors.white),
                    ),
                  ],
                ),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(AppColor.officialBlue),
                    backgroundColor: MaterialStateProperty.all<Color>(AppColor.officialBlue),
                    elevation: MaterialStateProperty.all(0.0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)), /*side: BorderSide(color: Colors.red)*/
                    ))),
                onPressed: () {},
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 1,
                color: Colors.black12,
                width: double.infinity,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Section",
                          style: TextStyle(color: AppColor.officialBlue, fontWeight: FontWeight.w500),
                        ),
                        CustomBuilderWidget(
                          keyValue: AllConstant.EMAIL_SEC,
                          defaultValue: "307",
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.black26,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Row",
                          style: TextStyle(color: AppColor.officialBlue, fontWeight: FontWeight.w500),
                        ),
                        CustomBuilderWidget(
                          keyValue: AllConstant.EMAIL_ROW,
                          defaultValue: "12",
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.black26,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Seat",
                          style: TextStyle(color: AppColor.officialBlue, fontWeight: FontWeight.w500),
                        ),
                        CustomBuilderWidget(
                          keyValue: AllConstant.EMAIL_SEAT,
                          defaultValue: "1 - 2",
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getYourOrderAmount() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFffffff),
          border: Border.all(color: Colors.black26),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Purchased:", style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w700, color: AppColor.black)),
                  CustomBuilderWidget(
                      keyValue: AllConstant.PURCHASED_DATE,
                      defaultValue: "Oct 10, 2024",
                      textStyle: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.black)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Paid:", style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w700, color: AppColor.black)),
                  CustomBuilderWidget(
                      keyValue: AllConstant.PAID_AMOUNT,
                      defaultValue: "\$15.89",
                      textStyle: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.black)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
