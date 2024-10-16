import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/all_uis/QRView.dart';
import 'package:ticket_master/all_uis/barcode_view.dart';

//import 'package:ticket_master/all_uis/barcode_view.dart';
import 'package:ticket_master/all_uis/ticket_details.dart';
import 'package:ticket_master/ios/barcode_view_ios.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/custom_dialog.dart';
import 'package:ticket_master/utils/future_stateful_widget.dart';
import 'package:ticket_master/utils/widgets_style.dart';
import 'package:ticket_master/utils/widgets_util.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

class CarouselWithIndicatorDemoIOS extends StatefulWidget {
  CarouselWithIndicatorDemoIOS();

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemoIOS> {
  int _current = 0;
  List<Widget>? imageSlidersM;
  List<Widget>? imageSlidersT;

  String? filePath;
  List<String> imgList = ["1"];
  int assetUrl = 1;
  int? updateValue;

  double doubleViewPort = 0.9;

  @override
  void initState() {
    initSlide();
    super.initState();
  }

  @override
  void didUpdateWidget(CarouselWithIndicatorDemoIOS oldWidget) {
    super.didUpdateWidget(oldWidget);
    initSlide();
  }

  bool showHideLogo = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    imageSlidersM = imgList
        .map((item) => Stack(
              children: <Widget>[
                buildMainCardHome(context, screenHeight),
              ],
            ))
        .toList();

    double? dblViewPort = PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.VIEWPORT_VALUE);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CarouselSlider(
        items: imageSlidersM,
        options: CarouselOptions(
            enableInfiniteScroll: false,
            viewportFraction: dblViewPort ?? 1,
            height: double.infinity,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
    );
  }

  Widget buildMainCardHome(BuildContext context, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        decoration: WidgetsStyle.BoxDecorationHomePage(),
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
                  height: 40,
                  child: GestureDetector(
                    onLongPress: () async {
                      String? result = await CustomInputDialog.showInputDialog(
                        context: context,
                        defaultTxt: "2166e5",
                        key: AllConstant.CURRENT_LIST_INDEX + AllConstant.COLOR_SECOND,
                      );
                      if (result != null) {
                        PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.COLOR_SECOND, result);
                        setState(() {});
                      } else {
                        print("Dialog was canceled");
                      }
                    },
                    child: Center(
                      child: CustomBuilderWidget(
                          keyValue: AllConstant.CURRENT_LIST_INDEX + AllConstant.HOME_SUB_TITLE,
                          defaultValue: "Standard Ticket",
                          style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.white)),
                    ),
                  ),
                ),
                SecRowSeat(_current),
                buildContainerImageBox(context),
                Container(
                  height: screenHeight * 0.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: FutureBuilder<String>(
                          future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.GATE_235, "GATE 2 3 5"),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              return GestureDetector(
                                onTap: () async {
                                  String? result = await CustomInputDialog.showInputDialog(
                                    context: context,
                                    defaultTxt: "GATE 2 3 5",
                                    key: AllConstant.CURRENT_LIST_INDEX + AllConstant.GATE_235,
                                  );
                                  if (result != null) {
                                    PrefUtil.preferences!.setString(
                                      AllConstant.CURRENT_LIST_INDEX + AllConstant.GATE_235,
                                      result,
                                    );
                                    setState(() {});
                                  } else {
                                    print("Dialog was canceled");
                                  }
                                },
                                child: Text(snapshot.data!,
                                    style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: Colors.black)),
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BarcodeViewIOS(_current)),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.colorSecond(),
                              border: Border.all(color: AppColor.colorSecond(), width: 1, style: BorderStyle.solid),
                            ),
                            height: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.qr_code,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "View Barcode",
                                  style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => TicketDetails()),
                                );
                              },
                              child: Text("Ticket Details",
                                  style:
                                      TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w700, color: AppColor.colorSecond())),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0, // Added left constraint for better layout control
              right: 0.0, // Added right constraint for better layout control
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.colorSecond(),
                    boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                    //BorderSide(color: AppColor.colorPrimary(), width: 0.5, style: BorderStyle.solid
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                  ),
                  height: 1,
                  width: double.infinity, // Use width here to avoid issues
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildRowFourDot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  //boxShadow: <BoxShadow>[BoxShadow(offset: Offset(0, 0), blurRadius: 4, color: Colors.black.withOpacity(.4))],
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  //boxShadow: <BoxShadow>[BoxShadow(offset: Offset(0, 0), blurRadius: 4, color: Colors.black.withOpacity(.4))],
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  //boxShadow: <BoxShadow>[BoxShadow(offset: Offset(0, 0), blurRadius: 4, color: Colors.black.withOpacity(.4))],
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  //boxShadow: <BoxShadow>[BoxShadow(offset: Offset(0, 0), blurRadius: 4, color: Colors.black.withOpacity(.4))],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container buildContainerImageBox(BuildContext context) {
    return Container(
      height: 200,
      /*decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/shadow.png"),
          fit: BoxFit.cover,
        ),
      ),*/
      child: Stack(
        children: [
          //Jimmy Kimmel LV Bowl Presented By Stifel
          FutureBuilder<File?>(
            future: CommonOperation.getImagePath(AllConstant.CURRENT_LIST_INDEX + AllConstant.IMAGE_PATH),
            builder: (context, AsyncSnapshot<File?> snapshot) {
              return GestureDetector(
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          content: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  child: Icon(
                                    Icons.camera_alt,
                                  ),
                                  onTap: () async {
                                    //pickImage(1, AllConstant.CURRENT_LIST_INDEX+AllConstant.IMAGE_PATH);
                                  },
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      //pickImage(2, AllConstant.CURRENT_LIST_INDEX+AllConstant.IMAGE_PATH);
                                    },
                                    child: Icon(Icons.file_copy))
                              ],
                            ),
                            //myPledge: model,
                          ),
                        );
                      });
                },
                //    File imageFile = File(pickedFile.path);
                child: snapshot.data != null
                    ? Stack(
                        children: [
                          Image.file(
                            snapshot.data!,
                            fit: BoxFit.cover,
                            height: 220.0,
                            width: double.infinity,
                          ),
                          Image.asset(
                            "assets/images/shadow.png",
                            fit: BoxFit.cover,
                            height: 220.0,
                            width: double.infinity,
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          Image.asset(
                            "assets/images/default_image_card.jpeg",
                            fit: BoxFit.cover,
                            height: 220.0,
                            width: double.infinity,
                          ),
                          Image.asset(
                            "assets/images/shadow.png",
                            fit: BoxFit.cover,
                            height: 220.0,
                            width: double.infinity,
                          ),
                        ],
                      ),
              );
            },
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width - 60,
                /* decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.9)
                    ])),*/
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 2,
                    ),
                    CustomBuilderWidget(
                        keyValue: AllConstant.CURRENT_LIST_INDEX + AllConstant.IAMGE_BIG_TEXT_2,
                        defaultValue: "Taylor Swift | The Eras Tour",
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontMain) ?? 18,
                            fontFamily: "metropolis",
                            fontWeight: CommonOperation.getFontWeight(),
                            color: AppColor.white)),
                    SizedBox(
                      height: 2,
                    ),
                    CustomBuilderWidget(
                        keyValue: AllConstant.CURRENT_LIST_INDEX + AllConstant.DATE,
                        defaultValue: "Sat, Dec 18, 4:30pm . SofFi Stadium",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontSecond) ?? 14,
                            fontFamily: "metropolis",
                            fontWeight: CommonOperation.getFontWeight2(),
                            color: AppColor.white)),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
