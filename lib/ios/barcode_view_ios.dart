import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/all_uis/barcode_share_view.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticket_master/all_uis/bottom_sheet_view_select_tickets.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ticket_master/utils/widgets_util.dart';

class BarcodeViewIOS extends StatefulWidget {
  final int _current;

  BarcodeViewIOS(this._current);

  @override
  _BarcodeViewIOSState createState() => _BarcodeViewIOSState();
}

class _BarcodeViewIOSState extends State<BarcodeViewIOS> {
  String? filePath;

  var textEditingController = TextEditingController();

  int assetUrl = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<File?>(
          future: CommonOperation.getImagePath(AllConstant.CURRENT_LIST_INDEX + AllConstant.IMAGE_PATH),
          builder: (context, AsyncSnapshot<File?> snapshot) {
            return snapshot.data != null
                ? Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: new FileImage(
                          snapshot.data!,
                        ),
                        fit: BoxFit.cover,
                      ),
                      //shape: BoxShape.circle,
                    ),
                    child: buildColumnMain(),
                  )
                : Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/album.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                      //shape: BoxShape.circle,
                    ),
                    child: buildColumnMain(),
                  );
          },
        ),
      ),
    );
  }

  Widget buildColumnMain() {
    return Stack(
      children: [
        Container(width: double.infinity,height: double.infinity,color: Colors.black38,),
        Container(
          height: 72,
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
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FutureBuilder<String>(
                      future:
                          CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.IAMGE_BIG_TEXT, "Taylor Swift | The Eras Tour"),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          return GestureDetector(
                            onTap: () async {
                              //showDialogInput(AllConstant.CURRENT_LIST_INDEX+AllConstant.IAMGE_BIG_TEXT);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - 100,
                              child: Text(snapshot.data!,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: AppColor.white())),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FutureBuilder<String>(
                      future: getTitleValueQr1(),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          return GestureDetector(
                            onTap: () async {
                              //showDialogInput(AllConstant.CURRENT_LIST_INDEX+AllConstant.IAMGE_BIG_TEXT);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - 100,
                              child: Text(snapshot.data!,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 12, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: AppColor.white())),
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
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  width: double.infinity,
                  height: 470,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: GestureDetector(
                                onLongPress: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => BarcodeShareView(widget._current)),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FutureBuilder<String>(
                                      future: CommonOperation.getSharedData(
                                          AllConstant.CURRENT_LIST_INDEX + AllConstant.STANDARD_ADMISSION, "Standard Admission"),
                                      builder: (context, AsyncSnapshot<String> snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container();
                                        } else {
                                          return GestureDetector(
                                            onTap: () {
                                              showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.STANDARD_ADMISSION, "Standard Admission2");
                                            },
                                            child: Text(snapshot.data!,
                                                style: TextStyle(
                                                    fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.white())),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          buildContainerTopTex(),
                          SizedBox(
                            height: 30,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.asset(
                              "assets/images/barcode.gif",
                              fit: BoxFit.contain,
                              width: double.infinity,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Image.asset(
                            "assets/images/logo/2.png",
                            height: 53,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(

                            child: FutureBuilder<String>(
                              future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.GATE_235, "GATE 2 3 5"),
                              builder: (context, AsyncSnapshot<String> snapshot) {
                                if (!snapshot.hasData) {
                                  return Container();
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.GATE_235, "American VIP - 7");
                                    },
                                    child: Text(snapshot.data!,
                                        style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: Colors.black)),
                                  );
                                }
                              },
                            ),
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

            ],
          ),
        ),

      ],
    );
  }

  Container buildContainerTopTex() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,

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
                  Text("SEC",
                      style:
                          TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight2(), color: AppColor.white())),
                  SizedBox(
                    height: 5,
                  ),
                  FutureBuilder<String>(
                    future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.SEC, "303"),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () {
                            showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.SEC, "303");
                          },
                          child: Text(snapshot.data!,
                              style: TextStyle(
                                  fontSize: 18, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight(), color: AppColor.white())),
                        );
                      }
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Text("ROW",
                      style:
                          TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight2(), color: AppColor.white())),
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
                          onTap: () {
                            showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.ROW, "5");
                          },
                          child: Text(snapshot.data!,
                              style: TextStyle(
                                  fontSize: 18, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight(), color: AppColor.white())),
                        );
                      }
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Text("SEAT",
                      style:
                          TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight2(), color: AppColor.white())),
                  SizedBox(
                    height: 5,
                  ),
                  FutureBuilder<String>(
                    future: CommonOperation.getSharedData(
                        AllConstant.CURRENT_LIST_INDEX + AllConstant.SEAT + widget._current.toString(), widget._current.toString()),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () {
                            showDialogInput(
                                AllConstant.CURRENT_LIST_INDEX + AllConstant.SEAT + widget._current.toString(), widget._current.toString(),
                                textInputType: TextInputType.number);
                          },
                          child: Text(snapshot.data!,
                              style: TextStyle(
                                  fontSize: 18, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight(), color: AppColor.white())),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  FutureBuilder<String>(
                    future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.GENERAL_ADMISSION, "General Admission"),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () {
                            showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.GENERAL_ADMISSION, "General Admission");
                          },
                          child: Text(snapshot.data!, style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.white())),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FutureBuilder<String>(
                    future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.GA3, "GA3"),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () {
                            showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.GA3, "GA3");
                          },
                          child: Text(snapshot.data!, style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: AppColor.white())),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),*/
        ],
      ),
    );
  }

  void showDialogInput(String sec, String defaultTxt, {TextInputType? textInputType}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetsUtil.inputBoxForAll(defaultTxt, sec, textEditingController, inputType: textInputType),
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
                        PrefUtil.preferences!.setString(sec, textEditingController.text);
                        textEditingController.text = "";
                        setState(() {});
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

  functionSell(String abc) {
    print(abc);
  }

  functionTransfer(String abc) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height - 400,
        child: BottomSheetViewSelectTickets(),
      ),
    );
  }
}
