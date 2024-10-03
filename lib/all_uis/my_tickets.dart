import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/all_uis/my_tickets_confirm.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/widgets_util.dart';

class MyTicketsNewView extends StatefulWidget {
  String ticketCount;
  String ticketTitle;

  MyTicketsNewView(this.ticketCount, this.ticketTitle);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<MyTicketsNewView> {
  int _current = 0;
  List<Widget>? imageSlidersM;
  List<String> imgList = ["1"];

  var seatRange = "";

  var textEditingController = TextEditingController();

  MapController controller = MapController(
    initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    areaLimit: BoundingBox(
      east: 10.4922941,
      north: 47.8084648,
      south: 45.817995,
      west: 5.9559113,
    ),
  );

  @override
  void initState() {
    initSlide();
    super.initState();
  }

  @override
  void didUpdateWidget(MyTicketsNewView oldWidget) {
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
              onTap: () {
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
            child: Text(
          "My Tickets",
          style: TextStyle(color: Colors.white, fontSize: 18),
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(children: [
              SizedBox(
                height: 30,
              ),
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
                    Expanded(flex: 1, child: Container()),
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
            ]),
            Container(
              height: 300,
              child: OSMFlutter(
                  controller: controller,
                  osmOption: OSMOption(
                    userTrackingOption: UserTrackingOption(
                      enableTracking: true,
                      unFollowUser: false,
                    ),
                    zoomOption: ZoomOption(
                      initZoom: 8,
                      minZoomLevel: 3,
                      maxZoomLevel: 19,
                      stepZoom: 1.0,
                    ),
                    userLocationMarker: UserLocationMaker(
                      personMarker: MarkerIcon(
                        icon: Icon(
                          Icons.location_history_rounded,
                          color: Colors.red,
                          size: 48,
                        ),
                      ),
                      directionArrowMarker: MarkerIcon(
                        icon: Icon(
                          Icons.double_arrow,
                          size: 48,
                        ),
                      ),
                    ),
                    roadConfiguration: RoadOption(
                      roadColor: Colors.yellowAccent,
                    ),
                    /* markerOption: MarkerOption(
                      defaultMarker: MarkerIcon(
                        icon: Icon(
                          Icons.person_pin_circle,
                          color: Colors.blue,
                          size: 56,
                        ),
                      )
                  ),*/
                  )),
            )
          ],
        ),
      ),
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
                            onTap: () {},
                            child: Text(snapshot.data!,
                                style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.white())),
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
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.ticketCount} tickets sent to",
                        style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 16),
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
                        onTap: () {
                          showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.ORDER, "6-44639/TOR");
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
                      GestureDetector(
                        onTap: () {
                          showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.ORDER, "6-44639/TOR");
                        },
                        child: Text("Cancel Transfer",
                            style: TextStyle(
                                fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w600, color: Colors.blueAccent.withOpacity(0.8))),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.colorGryaBlackMyTicket,
                      border: Border.all(color: AppColor.colorSecond(), width: 1, style: BorderStyle.solid),
                      boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                      //BorderSide(color: AppColor.colorPrimary(), width: 0.5, style: BorderStyle.solid
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                    ),
                    height: 40,
                    child: Center(
                      child: Image.asset(
                        "assets/images/icon_my_account/logo_ticket.png",
                        height: 20,
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
                        return Text(snapshot.data!,
                            style: TextStyle(
                                fontSize: 18, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight(), color: AppColor.white()));
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
                        return Text(snapshot.data!,
                            style: TextStyle(
                                fontSize: 18, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight(), color: AppColor.white()));
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
                  Text("${int.parse(widget.ticketCount) == 0 ? "0" : seatRange}",
                      style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight(), color: AppColor.white()))
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
      height: 220,
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
                                    color: AppColor.white())),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
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
                                    color: AppColor.white())),
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

  void showDialogInput(String sec, String defaultTxt) {
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
}
