import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/all_uis/QRView.dart';
import 'package:ticket_master/all_uis/barcode_view.dart';

//import 'package:ticket_master/all_uis/barcode_view.dart';
import 'package:ticket_master/all_uis/ticket_details.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/future_stateful_widget.dart';
import 'package:ticket_master/utils/widgets_style.dart';
import 'package:ticket_master/utils/widgets_util.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

class CarouselWithIndicatorAndroid extends StatefulWidget {
  CarouselWithIndicatorAndroid();

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorAndroid> {
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
  void didUpdateWidget(CarouselWithIndicatorAndroid oldWidget) {
    super.didUpdateWidget(oldWidget);
    initSlide();
  }

  bool showHideLogo = false;

  @override
  Widget build(BuildContext context) {
    /* imageSliders = [
      buildMainCardHome(context),
      buildMainCardHome(context),
    ];*/

    imageSlidersM = imgList
        .map((item) => Stack(
              children: <Widget>[
                buildMainCardHome(context),
              ],
            ))
        .toList();

    double? dblViewPort = PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.VIEWPORT_VALUE);

    return Scaffold(
      //appBar: AppBar(title: Text('Carousel with indicator demo')),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(children: [
        CarouselSlider(
          items: imageSlidersM,
          options: CarouselOptions(
              enableInfiniteScroll: false,
              viewportFraction: dblViewPort ?? 1.0,
              height: double.infinity,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                  print("_current");
                  print(_current);
                });
              }),
        ),
        /* GestureDetector(
          onTap: () async {
            String? result = await CustomInputDialog.showInputDialog(
              context: context,
              defaultTxt: "6",
              key: AllConstant.CURRENT_LIST_INDEX + AllConstant.CAROUSEL_COUNT,
            );
            if (result != null) {
              PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.CAROUSEL_COUNT, result);
              setState(() {});
            } else {
              print("Dialog was canceled");
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);
              return Container(
                width: _current == index ? 10.0 : 8.0,
                height: _current == index ? 10.0 : 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
        ),*/
      ]),
    );
  }

  Widget buildMainCardHome(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        decoration: WidgetsStyle.BoxDecorationHomePage(),
        height: MediaQuery.of(context).size.height - 210,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.colorSecond(),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                    //BorderSide(color: AppColor.colorPrimary(), width: 0.5, style: BorderStyle.solid
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Container(),
                            GestureDetector(
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
                              child: CustomBuilderWidget(
                                  keyValue: AllConstant.CURRENT_LIST_INDEX + AllConstant.HOME_SUB_TITLE,
                                  defaultValue: "Standard Ticket",
                                  style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      SecRowSeat(_current),
                    ],
                  ),
                ),
                buildContainerImageBox(context),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: CustomBuilderWidget(
                                  keyValue: AllConstant.CURRENT_LIST_INDEX + AllConstant.VIP_7,
                                  defaultValue: "GATE 1",
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.7))),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                assetUrl++;
                                if (assetUrl > 4) assetUrl = 1;

                                print("assetUrl");
                                print(assetUrl);

                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: GestureDetector(
                                  onLongPress: () {
                                    if (assetUrl == 4) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => BarcodeView(_current)),
                                      );
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      assetUrl == 1
                                          ? Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppColor.colorMain(),
                                                  //border: Border.all(color: AppColor.colorSecond(), width: 1, style: BorderStyle.solid),
                                                ),
                                                height: 45,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/bar_code.png",
                                                      height: 20,
                                                    ),
                                                    /*SvgPicture.asset(
                                                      "assets/images/barcode.svg",
                                                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                                    ),*/
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "View Ticket",
                                                      style: TextStyle(
                                                          fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Image.asset(
                                              "assets/images/logo/${assetUrl.toString()}.png",
                                              height: PrefUtil.preferences!.getInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.IMAGE_SIZE) == null
                                                  ? 50.0
                                                  : PrefUtil.preferences!.getInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.IMAGE_SIZE)!.toDouble(),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                        style: TextStyle(
                                            fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: AppColor.officialBlue)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1, right: 1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.colorMain().withOpacity(0.8),
                        //boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 1, spreadRadius: 1)],
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                      ),
                      height: 3,
                    ),
                  )),
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
                            height: double.infinity,
                            width: double.infinity,
                          ),
                          Image.asset(
                            "assets/images/shadow.png",
                            fit: BoxFit.cover,
                            height: double.infinity,
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
                width: MediaQuery.of(context).size.width - 70,
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
                    PrefUtil.preferences!.getBool(AllConstant.CURRENT_LIST_INDEX + AllConstant.IS_MULTILINE) == null ||
                            PrefUtil.preferences!.getBool(AllConstant.CURRENT_LIST_INDEX + AllConstant.IS_MULTILINE) == false
                        ? CustomBuilderWidget(
                            keyValue: AllConstant.CURRENT_LIST_INDEX + AllConstant.IAMGE_BIG_TEXT,
                            defaultValue: "Taylor Swift | The Eras Tour",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize:
                                    PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontMain) ?? 18,
                                fontFamily: "metropolis",
                                fontWeight: CommonOperation.getFontWeight(),
                                color: AppColor.white))
                        : Container(),
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
