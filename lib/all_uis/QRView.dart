import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticket_master/all_uis/bottom_sheet_view_select_tickets.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ticket_master/utils/future_stateful_widget.dart';
import 'package:ticket_master/utils/widgets_util.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

class QRViewMain extends StatefulWidget {
  const QRViewMain({Key? key}) : super(key: key);

  @override
  _QRViewMainState createState() => _QRViewMainState();
}

class _QRViewMainState extends State<QRViewMain> {
  String? filePath;

  int assetUrl = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.black,
        leading: GestureDetector(
            onTap: () async {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("My Tickets", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
            Text("Help", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Stack(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      AppColor.colorMain(),
                      //Colors.blueAccent,
                      AppColor.colorSecond(),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () async {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<String>(
                            future: CommonOperation.getSharedData(
                                AllConstant.CURRENT_LIST_INDEX + AllConstant.IAMGE_BIG_TEXT, "Taylor Swift | The Eras Tour"),
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              } else {
                                return GestureDetector(
                                  onTap: () async {},
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 100,
                                    child: Text(snapshot.data!,
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: AppColor.white)),
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          FutureBuilder<String>(
                            future: getTitleValueQr1(),
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              } else {
                                return GestureDetector(
                                  onTap: () async {},
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 100,
                                    child: Text(snapshot.data!,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 12, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: AppColor.white)),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 100.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.colorPageBackground,

                          boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                          //BorderSide(color: AppColor.colorPrimary(), width: 0.5, style: BorderStyle.solid
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        height: 470,
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColor.colorSecond(),

                                    boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                                    //BorderSide(color: AppColor.colorPrimary(), width: 0.5, style: BorderStyle.solid
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                                  ),
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        FutureBuilder<String>(
                                          future: CommonOperation.getSharedData(
                                              AllConstant.CURRENT_LIST_INDEX + AllConstant.HOME_SUB_TITLE, "Standard Ticket"),
                                          builder: (context, AsyncSnapshot<String> snapshot) {
                                            if (!snapshot.hasData) {
                                              return Container();
                                            } else {
                                              return GestureDetector(
                                                onTap: () async {
                                                  String? result = await CustomInputDialog.showInputDialog(
                                                    context: context,
                                                    defaultTxt: "Standard Ticket",
                                                    key: AllConstant.CURRENT_LIST_INDEX + AllConstant.HOME_SUB_TITLE,
                                                  );
                                                  if (result != null) {
                                                    PrefUtil.preferences!
                                                        .setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.HOME_SUB_TITLE, result);
                                                    setState(() {});
                                                  } else {
                                                    print("Dialog was canceled");
                                                  }
                                                },
                                                child: Text(snapshot.data!,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "metropolis",
                                                        fontWeight: FontWeight.normal,
                                                        color: AppColor.white)),
                                              );
                                            }
                                          },
                                        ),
                                        Icon(
                                          Icons.info_outline,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                buildContainerTopTex(),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColor.colorMain(),
                                    boxShadow: <BoxShadow>[BoxShadow(color: Colors.black54, blurRadius: 2.0, offset: Offset(0.0, 0.10))],
                                    //BorderSide(color: AppColor.colorPrimary(), width: 0.5, style: BorderStyle.solid
                                  ),
                                  child: FutureBuilder<String>(
                                    future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.VIP_7, "American VIP - 7"),
                                    builder: (context, AsyncSnapshot<String> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      } else {
                                        return GestureDetector(
                                          onTap: () async {
                                            String? result = await CustomInputDialog.showInputDialog(
                                              context: context,
                                              defaultTxt: "American VIP - 7",
                                              key: AllConstant.CURRENT_LIST_INDEX + AllConstant.VIP_7,
                                            );
                                            if (result != null) {
                                              PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.VIP_7, result);
                                              setState(() {});
                                            } else {
                                              print("Dialog was canceled");
                                            }
                                          },
                                          child: Center(
                                            child: Text(snapshot.data!,
                                                style: TextStyle(
                                                    fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: Colors.white)),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  height: 35,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Image.asset(
                                  "assets/images/QR.png",
                                  fit: BoxFit.contain,
                                  height: 170,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    assetUrl++;
                                    if (assetUrl > 4) assetUrl = 1;

                                    print("assetUrl");
                                    print(assetUrl);

                                    setState(() {});
                                  },
                                  child: Image.asset(
                                    "assets/images/logo/${assetUrl.toString()}.png",
                                    height: 53,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black26,
                        ),
                        SizedBox(
                          width: 20,
                        ),

                        FutureBuilder<String>(
                          future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.TWO_OF_TWO, "2 of 2"),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              return GestureDetector(
                                onTap: () async {
                                  String? result = await CustomInputDialog.showInputDialog(
                                    context: context,
                                    defaultTxt: "2 of 2",
                                    key: AllConstant.CURRENT_LIST_INDEX + AllConstant.TWO_OF_TWO,
                                  );
                                  if (result != null) {
                                    PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.TWO_OF_TWO, result);
                                    setState(() {});
                                  } else {
                                    print("Dialog was canceled");
                                  }
                                },
                                child: Text(snapshot.data!,
                                    style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: Colors.black26)),
                              );
                            }
                          },
                        ),

                        //Text("2 of 2", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: Colors.black26)),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black26,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: TransferAndSellButton(
                    function: () {},
                    isButton1Enable: true,
                    isButton2Enable: true,
                  ),
                ),
              ),
            ],
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
                  CustomBuilderWidget(
                      keyValue:AllConstant.CURRENT_LIST_INDEX + AllConstant.SEAT,
                      defaultValue: "4",
                      textInputType: TextInputType.number,
                      style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: AppColor.white))

                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<String> getTitleValueQr1() async {
    var value1 = await CommonOperation.getSharedData(
      AllConstant.CURRENT_LIST_INDEX + AllConstant.STUDIUM,
      "SoFi Studium",
    );

    var value2 = await CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.DATE, "Sat, Dec 18, 4:30pm . SofFi Stadium");
    var value3 = await CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.TIME, "4:30pm .");

    return value2;
  }

  Future<void> pickImage(int i, String path) async {
    Navigator.of(context).pop();
    final pickedFile = await ImagePicker().pickImage(
      source: i == 1 ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
    );
    filePath = pickedFile!.path;
    print("filePath");
    print(filePath);
    PrefUtil.preferences!.setString(path, filePath!);
    setState(() {});
  }
}
