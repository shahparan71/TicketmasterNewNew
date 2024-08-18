import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/all_uis/QRView.dart';
import 'package:ticket_master/all_uis/barcode_view.dart';

//import 'package:ticket_master/all_uis/barcode_view.dart';
import 'package:ticket_master/all_uis/ticket_details.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/widgets_util.dart';

class CarouselWithIndicatorDemo extends StatefulWidget {
  CarouselWithIndicatorDemo();

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  List<Widget>? imageSlidersM;
  List<Widget>? imageSlidersT;
  var textEditingController = TextEditingController();
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
  void didUpdateWidget(CarouselWithIndicatorDemo oldWidget) {
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
      body: Column(children: [
        CarouselSlider(
          items: imageSlidersM,
          options: CarouselOptions(
              enableInfiniteScroll: false,
              viewportFraction: dblViewPort ?? 0.9,
              height: MediaQuery.of(context).size.height - 200,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                  print("_current");
                  print(_current);
                });
              }),
        ),
        GestureDetector(
          onTap: () {
            showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.CAROUSEL_COUNT, "6", inputType: TextInputType.number);
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
        ),
      ]),
    );
  }

  Widget buildMainCardHome(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
          color: AppColor.white(),
          border: Border.all(color: AppColor.colorPageBackground(), width: 1, style: BorderStyle.solid),
          boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
          //BorderSide(color: AppColor.colorPrimary(), width: 0.5, style: BorderStyle.solid
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        height: MediaQuery.of(context).size.height - 200,
        child: Stack(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.COLOR_SECOND, "2166e5");
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.colorSecond(),

                      boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                      //BorderSide(color: AppColor.colorPrimary(), width: 0.5, style: BorderStyle.solid
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                    ),
                    height: 40,
                    child: Center(
                      child: FutureBuilder<String>(
                        future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.HOME_SUB_TITLE, "Verified Fan Offer"),
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          } else {
                            return GestureDetector(
                              onTap: () {
                                showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.HOME_SUB_TITLE, "Verified Fan Offer");
                              },
                              child: Text(snapshot.data!, style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.white())),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                buildContainerTopTex(),
                buildContainerImageBox(context),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: FutureBuilder<String>(
                          future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.VIP_7, "American VIP - 7"),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.VIP_7, "American VIP - 7");
                                },
                                child: Text(snapshot.data!, style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: Colors.black)),
                              );
                            }
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
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
                            child: Image.asset(
                              "assets/images/logo/${assetUrl.toString()}.png",
                              height: PrefUtil.preferences!.getInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.IMAGE_SIZE) == null
                                  ? 50.0
                                  : PrefUtil.preferences!.getInt(AllConstant.CURRENT_LIST_INDEX + AllConstant.IMAGE_SIZE)!.toDouble(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Row(
                          mainAxisAlignment: assetUrl == 4 ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                          children: [
                            assetUrl == 4
                                ? Container()
                                : GestureDetector(
                                    child: Text("View Barcode", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w700, color: AppColor.colorSecond())),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => QRViewMain()),
                                      );
                                    },
                                  ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => TicketDetails()),
                                );
                              },
                              child: Text("Ticket Details", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w700, color: AppColor.colorSecond())),
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
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showHideLogo = !showHideLogo;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.colorSecond(),
                        border: Border.all(color: AppColor.colorSecond(), width: 1, style: BorderStyle.solid),
                        boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                        //BorderSide(color: AppColor.colorPrimary(), width: 0.5, style: BorderStyle.solid
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                      ),
                      height: 40,
                      child: Center(
                        child: showHideLogo == true
                            ? Container()
                            : Image.asset(
                                "assets/images/tm_verified.png",
                                height: 25,
                              ),
                      ),
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

  Widget buildContainerTopTex() {
    return GestureDetector(
      onTap: () {
        //COLOR_MAIN
        showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.COLOR_MAIN, "2166e5");
      },
      child: Container(
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
                    Text("SEC", style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight2(), color: AppColor.white())),
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
                            child: Text(snapshot.data!, style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight(), color: AppColor.white())),
                          );
                        }
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("ROW", style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight2(), color: AppColor.white())),
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
                            child: Text(snapshot.data!, style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight(), color: AppColor.white())),
                          );
                        }
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("SEAT", style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight2(), color: AppColor.white())),
                    SizedBox(
                      height: 5,
                    ),
                    FutureBuilder<String>(
                      future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.SEAT + _current.toString(), _current.toString()),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          return GestureDetector(
                            onTap: () {
                              showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.SEAT + _current.toString(), _current.toString());
                            },
                            child: Text(snapshot.data!, style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight(), color: AppColor.white())),
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
      ),
    );
  }

  Container buildContainerImageBox(BuildContext context) {
    return Container(
      height: 220,
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
                                  onTap: () {
                                    //pickImage(1, AllConstant.CURRENT_LIST_INDEX+AllConstant.IMAGE_PATH);
                                  },
                                ),
                                GestureDetector(
                                    onTap: () {
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
                            "assets/images/album.jpg",
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
                    PrefUtil.preferences!.getBool(AllConstant.CURRENT_LIST_INDEX + AllConstant.IS_MULTILINE) == null ||
                            PrefUtil.preferences!.getBool(AllConstant.CURRENT_LIST_INDEX + AllConstant.IS_MULTILINE) == false
                        ? FutureBuilder<String>(
                            future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.IAMGE_BIG_TEXT, "Taylor Swift | The Eras Tour"),
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              } else {
                                return GestureDetector(
                                  onTap: () async {
                                    showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.IAMGE_BIG_TEXT, "Taylor Swift | The Eras Tour");
                                  },
                                  child: Container(
                                    child: Text(snapshot.data!,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontMain) ?? 18,
                                            fontFamily: "metropolis",
                                            fontWeight: CommonOperation.getFontWeight(),
                                            color: AppColor.white())),
                                  ),
                                );
                              }
                            },
                          )
                        : Container(),
                    SizedBox(
                      height: 2,
                    ),
                    FutureBuilder<String>(
                      future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.IAMGE_BIG_TEXT_2, "Taylor Swift | The Eras Tour"),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          return GestureDetector(
                            onTap: () async {
                              showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.IAMGE_BIG_TEXT_2, "Taylor Swift | The Eras Tour");
                            },
                            child: Container(
                              child: Text(snapshot.data!,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontMain) ?? 18,
                                      fontFamily: "metropolis",
                                      fontWeight: CommonOperation.getFontWeight(),
                                      color: AppColor.white())),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    FutureBuilder<String>(
                      future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.DATE, "Sat, Dec 18, 4:30pm . SofFi Stadium"),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          return GestureDetector(
                            onTap: () async {
                              showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.DATE, "Sat, Dec 18, 4:30pm . SofFi Stadium");
                            },
                            child: Container(
                              child: Text(snapshot.data!,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontSecond) ?? 14,
                                      fontFamily: "metropolis",
                                      fontWeight: CommonOperation.getFontWeight2(),
                                      color: AppColor.white())),
                            ),
                          );
                        }
                      },
                    ),
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
                  WidgetsUtil.inputBoxForAll(defaultTxt, sec, textEditingController,inputType: inputType),
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
                        if (inputType != null) initSlide();
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

  Future<void> initSlide() async {
    String value = await CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.CAROUSEL_COUNT, "6");
    if (value != null || value.isNotEmpty) {
      imgList.clear();
      for (int i = 0; i < int.parse(value); i++) {
        imgList.add(i.toString());
      }
      setState(() {});
    }
  }
}
