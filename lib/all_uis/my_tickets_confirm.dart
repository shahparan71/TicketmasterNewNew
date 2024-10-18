import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/future_stateful_widget.dart';
import 'package:ticket_master/utils/widgets_style.dart';
import 'package:ticket_master/utils/widgets_util.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

class MyTicketsConfirmNewView extends StatefulWidget {
  String ticketCount;
  String ticketTitle;

  MyTicketsConfirmNewView(this.ticketCount, this.ticketTitle);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<MyTicketsConfirmNewView> {
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
  void didUpdateWidget(MyTicketsConfirmNewView oldWidget) {
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

    return PopScope(
      canPop: false,
      onPopInvoked : (didPop){
        // logic
      },
      child: Scaffold(
        //appBar: AppBar(title: Text('Carousel with indicator demo')),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColor.colorSecond(),
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () async {
                  Navigator.pop(context); //
                },
                child: Container(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )),
          ),
          
          elevation: 0.0,
          title: Center(
              child: Text(
            "My Tickets",
            style: TextStyle(color: Colors.white, fontSize: 18),
          )),
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height - 100,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 15,bottom: 15),
              child: Stack(children: [

                CarouselSlider(
                  items: imageSlidersM,
                  options: CarouselOptions(
                      enableInfiniteScroll: false,
                      viewportFraction: dblViewPort ?? 1.0,
                      height: MediaQuery.of(context).size.height - 220,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                          print("_current");
                          print(_current);
                        });
                      }),
                ),
                Positioned(
                  bottom: 60,
                  left: 0,
                  right: 0,
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
                          color: _current == index ? AppColor.colorSecond() : AppColor.colorSecond().withOpacity(0.4),
                        ),
                      );
                    }).toList(),
                  ),
                ),
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
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMainCardHome(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Container(
        decoration: WidgetsStyle.BoxDecorationHomePage(),
        height: double.infinity,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.colorSecond(),
                    boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                    //BorderSide(color: AppColor.colorPrimary(), width: 0.5, style: BorderStyle.solid
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 40,
                        child: Center(
                          child: FutureBuilder<String>(
                            future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.HOME_SUB_TITLE, "Standard Ticket"),
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
                      //buildContainerTopTex(),
                      SecRowSeatJustShow(widget.ticketCount, seatRange),
                    ],
                  ),
                ),
                buildContainerImageBox(context),
                Container(
                  height: 20,
                  color: AppColor.colorSecond(),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Text(
                    "Accepted",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 180,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Tickets successfully accepted by the recipient",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "and no longer valid in your account for event entry ",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.normal, fontSize: 14),
                            ),
                          ],
                        ),
                        Container(
                          child: Lottie.asset(
                            'assets/images/animation_llahve39.json',
                            repeat: false,
                          ),
                          height: 100,
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            WidgetsUtil.cardThinUnderLine()
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
