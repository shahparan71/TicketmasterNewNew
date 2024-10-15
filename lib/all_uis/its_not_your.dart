import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/main_landing_screen.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/widgets_util.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

class ItsNotYou extends StatefulWidget {
  const ItsNotYou({Key? key}) : super(key: key);

  @override
  _ItsNotYouState createState() => _ItsNotYouState();
}

class _ItsNotYouState extends State<ItsNotYou> {
  String? filePath;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 1.0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/images/t.png"),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Container(
          height: 300,
          margin: const EdgeInsets.only(top: 50.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.white,
              border: Border.all(color: AppColor.colorPageBackground, width: 1, style: BorderStyle.solid),
              boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
              //BorderSide(color: AppColor.colorPrimary(), width: 0.5, style: BorderStyle.solid
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("It's not you - it's us.",
                      style: TextStyle(fontSize: 20, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(
                    height: 40,
                  ),
                  Text("We're sorry, we're unable to process your request. Please try again.",
                      style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: Colors.black54)),
                  SizedBox(
                    height: 40,
                  ),
                  Text("6e4dd0a3-17da-487f-8a60-b41f6eea03be",
                      style: TextStyle(fontSize: 12, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: Colors.grey)),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    child: Text("Return to Event Page",
                        style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.colorMain(),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainLandingScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Container buildContainerTopTex() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.colorMain(),

        //BorderSide(color: AppColor.colorPrimary(), width: 0.5, style: BorderStyle.solid
      ),
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("SEC", style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.white)),
                  SizedBox(
                    height: 5,
                  ),
                  FutureBuilder<String>(
                    future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.SEC, "407A"),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () async {
                            String? result = await CustomInputDialog.showInputDialog(
                              context: context,
                              defaultTxt: "407A",
                              key: AllConstant.CURRENT_LIST_INDEX + AllConstant.SEC,
                            );
                            if (result != null) {
                              PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.SEC, result);
                              setState(() {});
                            } else {
                              print("Dialog was canceled");
                            }
                          },
                          child: Text(snapshot.data!,
                              style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: AppColor.white)),
                        );
                      }
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Text("ROW", style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.white)),
                  SizedBox(
                    height: 5,
                  ),
                  FutureBuilder<String>(
                    future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.ROW, "5"),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () async {
                            String? result = await CustomInputDialog.showInputDialog(
                              context: context,
                              defaultTxt: "5",
                              key: AllConstant.CURRENT_LIST_INDEX + AllConstant.ROW,
                            );
                            if (result != null) {
                              PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.ROW, result);
                              setState(() {});
                            } else {
                              print("Dialog was canceled");
                            }
                          },
                          child: Text(snapshot.data!,
                              style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: AppColor.white)),
                        );
                      }
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Text("SEAT", style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.white)),
                  SizedBox(
                    height: 5,
                  ),
                  FutureBuilder<String>(
                    future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.SEAT, "4"),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () async {
                            String? result = await CustomInputDialog.showInputDialog(
                              context: context,
                              defaultTxt: "4",
                              key: AllConstant.CURRENT_LIST_INDEX + AllConstant.SEAT,
                            );
                            if (result != null) {
                              PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.SEAT, result);
                              setState(() {});
                            } else {
                              print("Dialog was canceled");
                            }
                          },
                          child: Text(snapshot.data!,
                              style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: AppColor.white)),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
