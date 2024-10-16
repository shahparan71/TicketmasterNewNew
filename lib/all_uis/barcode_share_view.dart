import 'dart:collection';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
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
import 'package:ticket_master/utils/widgets_util.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

class BarcodeShareView extends StatefulWidget {
  final int _MainCurrent;

  BarcodeShareView(this._MainCurrent);

  @override
  _BarcodeShareViewState createState() => _BarcodeShareViewState();
}

class _BarcodeShareViewState extends State<BarcodeShareView> {
  String? filePath;

  int assetUrl = 1;

  List<Widget> imageSlidersM = [];
  List<String> imgList = ["1"];
  int _currentBarCodeSlide = 0;

  @override
  void initState() {
    initSlide();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imageSlidersM = imgList
        .map((item) => Stack(
              children: <Widget>[
                buildMainCardHome(context),
              ],
            ))
        .toList();

    return SafeArea(
      child: Scaffold(
        /*appBar: AppBar(
      backgroundColor: AppColor.black,
      leading: Icon(Icons.close),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("My Tickets",
              style: TextStyle(
                  fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
          Text("Help",
              style: TextStyle(
                  fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
        ],
      ),
        ),*/
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
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
                          onTap: () async {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FutureBuilder<String>(
                            future: CommonOperation.getSharedData(
                                AllConstant.CURRENT_LIST_INDEX + AllConstant.IAMGE_BIG_TEXT, "Taylor Swift | The Eras Tour"),
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              } else {
                                return GestureDetector(
                                  onTap: () async {

                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 100,
                                    child: Text(snapshot.data!,
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: AppColor.white)),
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

                                  },
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
              Column(
                children: [
                  CarouselSlider(
                    items: imageSlidersM,
                    options: CarouselOptions(
                        enableInfiniteScroll: false,
                        viewportFraction: 0.9,
                        height: MediaQuery.of(context).size.height - 200,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentBarCodeSlide = index;
                            print("_currentBarCodeSlide2");
                            print(_currentBarCodeSlide);
                          });
                        }),
                  ),
                  GestureDetector(
                    onTap: () async {

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imageSlidersM.map((url) {
                        int index = imageSlidersM.indexOf(url);
                        return Container(
                          width: _currentBarCodeSlide == index ? 10.0 : 8.0,
                          height: _currentBarCodeSlide == index ? 10.0 : 8.0,
                          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentBarCodeSlide == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0XFFffffff),
                              boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 5, spreadRadius: 5)],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: WidgetsUtil.CustomElevatedButton(
                                          buttonText: "Share",
                                          function: functionTransfer,
                                          color: AppColor.colorBlueLight(),
                                          fontWeight: FontWeight.w600)),
                                  /*SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(flex: 1, child: WidgetsUtil.CustomElevatedButton(buttonText: "Sell", function: functionSell)),*/
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildContainerTopTex() {
    print("_currentBarCodeSilde");
    print(_currentBarCodeSlide);

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
                  Text("SEC",
                      style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight2(), color: AppColor.white)),
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
                              style: TextStyle(
                                  fontSize: 18, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight(), color: AppColor.white)),
                        );
                      }
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Text("ROW",
                      style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight2(), color: AppColor.white)),
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
                              style: TextStyle(
                                  fontSize: 18, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight(), color: AppColor.white)),
                        );
                      }
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Text("SEAT",
                      style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight2(), color: AppColor.white)),
                  SizedBox(
                    height: 5,
                  ),
                  FutureBuilder<String>(
                    future: CommonOperation.getSharedData(
                        AllConstant.CURRENT_LIST_INDEX + AllConstant.SEAT + _currentBarCodeSlide.toString(), _currentBarCodeSlide.toString()),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () async {
                            String? result = await CustomInputDialog.showInputDialog(
                                context: context,
                                defaultTxt: _currentBarCodeSlide.toString(),
                                key: AllConstant.CURRENT_LIST_INDEX + AllConstant.SEAT + _currentBarCodeSlide.toString());
                            if (result != null) {
                              PrefUtil.preferences!
                                  .setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.SEAT + _currentBarCodeSlide.toString(), result);
                              setState(() {});
                            } else {
                              print("Dialog was canceled");
                            }
                          },
                          child: Text(snapshot.data!,
                              style: TextStyle(
                                  fontSize: 18, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight(), color: AppColor.white)),
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
                          onTap: () async {

                          },
                          child: Text(snapshot.data!, style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.white)),
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
                          onTap: () async {

                          },
                          child: Text(snapshot.data!, style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: AppColor.white)),
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
    showMaterialModalBottomSheet( isDismissible: false,  // Prevents closing by tapping outside
                    enableDrag: false,    
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height - 450,
        child: BottomSheetViewSelectTickets(),
      ),
    );
  }

  buildMainCardHome(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.colorPageBackground,
                border: Border.all(color: AppColor.colorPageBackground, width: 1, style: BorderStyle.solid),
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
                          child: GestureDetector(
                            onTap: () async {},
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
                                        onTap: () async {
                                          String? result = await CustomInputDialog.showInputDialog(
                                            context: context,
                                            defaultTxt: "Standard Admission",
                                            key: AllConstant.CURRENT_LIST_INDEX + AllConstant.STANDARD_ADMISSION,
                                          );
                                          if (result != null) {
                                            PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.STANDARD_ADMISSION, result);
                                            setState(() {});
                                          } else {
                                            print("Dialog was canceled");
                                          }
                                        },
                                        child: Text(snapshot.data!,
                                            style: TextStyle(
                                                fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.white)),
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
                      Image.asset(
                        "assets/images/barcode.gif",
                        fit: BoxFit.contain,
                        height: 170,
                      ),
                      SizedBox(
                        height: 40,
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
        ],
      ),
    );
  }

  Future<void> initSlide() async {
    String value = await CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.SELECTED_TICKET_COUNT, "6");
    if (value != null || value.isNotEmpty) {
      imgList.clear();
      for (int i = 0; i < int.parse(value); i++) {
        imgList.add(i.toString());
      }
      setState(() {});
    }
  }
}
