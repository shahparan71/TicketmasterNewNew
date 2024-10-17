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
import 'package:ticket_master/utils/future_stateful_widget.dart';
import 'package:ticket_master/utils/widgets_style.dart';
import 'package:ticket_master/utils/widgets_util.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

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
      backgroundColor: Colors.white,
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
        title: Row(
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
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 50,
        child: Stack(children: [
          SizedBox(
            height: 3,
          ),
          CarouselSlider(
            items: imageSlidersM,
            options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: dblViewPort ?? 1.0,
                height: MediaQuery.of(context).size.height - 200,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                    print("_current");
                    print(_current);
                  });
                }),
          ),
          /*Row(
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
          ),*/
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: TransferAndSellButton(
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyTicketsConfirmNewView(widget.ticketCount, widget.ticketTitle)),
                );
              },
              isButton1Enable: true,
              isButton2Enable: true,
              button1Color: Colors.black26,
            ),
          )
        ]),
      ),
    );
  }

  Widget buildMainCardHome(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        decoration: WidgetsStyle.BoxDecorationHomePage(),
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              child: Column(
                children: [
                  Container(
                    height: 330,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.colorSecond(),
                                borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                              ),
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  Container(),
                                  Container(),
                                  FutureBuilder<String>(
                                    future:
                                        CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.HOME_SUB_TITLE, "Standard Ticket"),
                                    builder: (context, AsyncSnapshot<String> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      } else {
                                        return GestureDetector(
                                          onTap: () async {},
                                          child: Text(snapshot.data!,
                                              style: TextStyle(
                                                  fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.white)),
                                        );
                                      }
                                    },
                                  ),
                                  Container(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SecRowSeatJustShow(widget.ticketCount, seatRange),
                            buildContainerImageBox(context),
                          ],
                        ),
                        Container(
                          height: 330,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.gray.withOpacity(0.4),
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                              style: TextStyle(
                                  fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w600, color: Colors.blueAccent.withOpacity(0.8))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.colorMain(),
                      border: Border.all(color: AppColor.colorMain(), width: 1, style: BorderStyle.solid),
                      boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                      //BorderSide(color: AppColor.colorPrimary(), width: 0.5, style: BorderStyle.solid
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                    ),
                    height: 2,
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
                      height: 10,
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
