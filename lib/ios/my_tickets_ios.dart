import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/maps/map_widgets.dart';
import 'package:ticket_master/all_uis/my_tickets_confirm.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/custom_dialog.dart';
import 'package:ticket_master/utils/widgets_util.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

class MyTicketsiOS extends StatefulWidget {
  String ticketCount;
  String ticketTitle;

  MyTicketsiOS(this.ticketCount, this.ticketTitle);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<MyTicketsiOS> {
  int _current = 0;
  List<Widget>? imageSlidersM;
  List<String> imgList = ["1"];

  var seatRange = "";

  @override
  void initState() {
    initSlide();
    super.initState();
  }

  @override
  void didUpdateWidget(MyTicketsiOS oldWidget) {
    super.didUpdateWidget(oldWidget);
    initSlide();
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

    double? dblViewPort = PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.VIEWPORT_VALUE);

    return Scaffold(
      //appBar: AppBar(title: Text('Carousel with indicator demo')),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Container(
          child: GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();
                print("d9f0d9fd");
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
              )),
        ),
        elevation: 0.0,
        backgroundColor: AppColor.colorSecond(),
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Text(
              "My Tickets",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Container(),
            Container()
          ],
        )),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Column(children: [
              SizedBox(
                height: 2,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 320,
                child: CarouselSlider(
                  items: imageSlidersM,
                  options: CarouselOptions(
                      enableInfiniteScroll: false,
                      viewportFraction: dblViewPort ?? 1.0,
                      height: MediaQuery.of(context).size.height - 250,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                          print("_current");
                          print(_current);
                        });
                      }),
                ),
              ),
              Row(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        child: Text("Transfer",
                            style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(AppColor.colorMain()),
                            backgroundColor: MaterialStateProperty.all<Color>(AppColor.colorMain()),
                            elevation: MaterialStateProperty.all(0.0),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)), /*side: BorderSide(color: Colors.red)*/
                            ))),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyTicketsConfirmNewView(widget.ticketCount, widget.ticketTitle)),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        child: Text("Sell",
                            style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
                        /*style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.colorGryaMyTicket.withOpacity(0.1),
                        ),*/
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(AppColor.colorGryaMyTicket.withOpacity(0.1)),
                            backgroundColor: MaterialStateProperty.all<Color>(AppColor.colorGryaMyTicket.withOpacity(0.1)),
                            elevation: MaterialStateProperty.all(0.0),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)), /*side: BorderSide(color: Colors.red)*/
                            ))),
                        onPressed: () async {
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QRViewMain()),
                          );*/
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 350, child: GoogleMapFlutter())
            ]),
            //Platform.isAndroid?Container(): MapWidgets()
          ],
        ),
      ),
    );
  }

  Widget buildMainCardHome(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
          color: AppColor.white,
          //border: Border.all(color: AppColor.colorPageBackground, width: 1, style: BorderStyle.solid),
          boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 1, spreadRadius: 1)],
          //BorderSide(color: AppColor.colorPrimary(), width: 0.5, style: BorderStyle.solid
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        height: MediaQuery.of(context).size.height - 200,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 334,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.colorGryaBlackMyTicket,

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
                              onTap: () async {},
                              child: Text(snapshot.data!,
                                  style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.white)),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  buildContainerTopTex(),
                  buildContainerImageBox(context),
                  Container(
                    height: 20,
                    color: AppColor.colorSecond(),
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Text(
                      "Sent",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 190,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "${widget.ticketCount} tickets sent to",
                                style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("${PrefUtil.preferences!.get(AllConstant.CURRENT_LIST_INDEX + AllConstant.EMAIL)} waiting for recipient to claim.",
                                  textAlign: TextAlign.center,
                                  //style: TextStyle(color: Colors.black.withOpacity(0.8)),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "metropolis",
                                      fontWeight: CommonOperation.getFontWeight2(),
                                      color: Colors.black.withOpacity(0.8))),
                              SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  String? result = await CustomInputDialog.showInputDialog(
                                    context: context,
                                    defaultTxt: "6-44639/TOR",
                                    key: AllConstant.CURRENT_LIST_INDEX + AllConstant.ORDER,
                                  );
                                  if (result != null) {
                                    PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.ORDER, result);
                                    setState(() {});
                                  } else {
                                    print("Dialog was canceled");
                                  }
                                },
                                child: Text("Order ${PrefUtil.preferences!.get(AllConstant.CURRENT_LIST_INDEX + AllConstant.ORDER) ?? "6-44639/TOR"}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "metropolis",
                                        fontWeight: CommonOperation.getFontWeight2(),
                                        color: Colors.black.withOpacity(0.8))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  String? result = await CustomInputDialog.showInputDialog(
                                    context: context,
                                    defaultTxt: "6-44639/TOR",
                                    key: AllConstant.CURRENT_LIST_INDEX + AllConstant.ORDER,
                                  );
                                  if (result != null) {
                                    PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.ORDER, result);
                                    setState(() {});
                                  } else {
                                    print("Dialog was canceled");
                                  }
                                },
                                child: Text("Cancel Transfer",
                                    style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w600, color: Colors.blueAccent)),
                              ),
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
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

  Widget buildContainerTopTex() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.colorGryaMyTicket,

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
                        return Text(snapshot.data!,
                            style: TextStyle(
                                fontSize: 18, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight(), color: AppColor.white));
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
                        return Text(snapshot.data!,
                            style: TextStyle(
                                fontSize: 18, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight(), color: AppColor.white));
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
                  Text("${int.parse(widget.ticketCount) == 0 ? "0" : seatRange}",
                      style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight(), color: AppColor.white))
                ],
              ),
            ],
          ),
        ],
      ),
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
              return snapshot.data != null
                  ? Stack(
                      children: [
                        Image.file(
                          snapshot.data!,
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: double.infinity,
                        ),
                        Image.asset(
                          "assets/images/shadow.png",
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: double.infinity,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Opacity(
                              child: Image.asset(
                                "assets/images/icon_my_account/large_arrow.png",
                                width: 70,
                                height: 70,
                              ),
                              opacity: 0.9,
                            ),
                          ),
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
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Opacity(
                              child: Image.asset(
                                "assets/images/icon_my_account/large_arrow.png",
                                width: 70,
                                height: 70,
                              ),
                              opacity: 0.9,
                            ),
                          ),
                        ),
                      ],
                    );
            },
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width - 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FutureBuilder<String>(
                      future: CommonOperation.getSharedData(
                          AllConstant.CURRENT_LIST_INDEX + AllConstant.IAMGE_BIG_TEXT_2, "Taylor Swift | The Eras Tour"),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          return Container(
                            child: Text(snapshot.data!,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize:
                                        PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontMain) ?? 18,
                                    fontFamily: "metropolis",
                                    fontWeight: CommonOperation.getFontWeight(),
                                    color: AppColor.white)),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FutureBuilder<String>(
                      future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.DATE, "Sat, Dec 18, 4:30pm . SofFi Stadium"),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          return Container(
                            child: Text(snapshot.data!,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize:
                                        PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontSecond) ??
                                            14,
                                    fontFamily: "metropolis",
                                    fontWeight: CommonOperation.getFontWeight2(),
                                    color: AppColor.white)),
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

  Future<void> initSlide() async {
    seatRange = await CommonOperation.getSortValue(widget.ticketTitle.trim());

    var tt = seatRange.split(",");

    if (tt.length == 2) {
      seatRange = tt[0] + " -" + tt[1];
    }
    if (tt.length > 2) {
      seatRange = tt[0] + " -" + tt[tt.length - 1];
    }

    int value = int.parse(widget.ticketCount);
    if (value != null) {
      value = value == 0 ? 1 : value;
      imgList.clear();
      for (int i = 0; i < value; i++) {
        imgList.add(i.toString());
      }
      setState(() {});
    }
  }
}
