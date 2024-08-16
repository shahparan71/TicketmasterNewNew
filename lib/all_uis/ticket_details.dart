import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/widgets_util.dart';

class TicketDetails extends StatefulWidget {
  const TicketDetails({Key? key}) : super(key: key);

  @override
  _TicketDetailsState createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  var textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColor.black(),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Ticket Details", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
              Text("Help", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
            ],
          ),
        ),
        body: homeMain(),
      ),
    );
  }

  homeMain() {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            viewTag("Seat Location", "AA2/19/14", AllConstant.CURRENT_LIST_INDEX + AllConstant.DT1),
            Container(
              height: 1,
              color: Colors.black26,
            ),

            viewTag("The 1975 At Their Very Best - North America 2023 ", "Sun, Aug 6, 7pm • Tom Moffatt Waikiki Shell", AllConstant.CURRENT_LIST_INDEX + AllConstant.DT2, isTitleClickable: true),
            Container(
              height: 1,
              color: Colors.black26,
            ),

            viewTag("Entry Info", "RAIN OR SHINE", AllConstant.CURRENT_LIST_INDEX + AllConstant.DT3),
            Container(
              height: 1,
              color: Colors.black26,
            ),

            viewTag("Ticket Info ", "BAMP PROJECT PRESENTS---THE 1975---AT THEIR VERY BEST---TOM MOFFATT WAIKIKI SHELL---SUN AUG 06 2023 7:00 PM ", AllConstant.CURRENT_LIST_INDEX + AllConstant.DT4,
                isBreak: true),
            Container(
              height: 1,
              color: Colors.black26,
            ),

            viewTag("Barcode Number ", "130165913639134463c ", AllConstant.CURRENT_LIST_INDEX + AllConstant.DT5),
            Container(
              height: 1,
              color: Colors.black26,
            ),

            viewTag("Tom Moffatt Waikiki Shell ", "Honolulu HI US ", AllConstant.CURRENT_LIST_INDEX + AllConstant.DT6, isTitleClickable: true),
            Container(
              height: 1,
              color: Colors.black26,
            ),

            viewTag("Order Number ", "35-47612/WES ", AllConstant.CURRENT_LIST_INDEX + AllConstant.DT7),
            Container(
              height: 1,
              color: Colors.black26,
            ),

            viewTag("Ticket Type ", "BAMP Presale ", AllConstant.CURRENT_LIST_INDEX + AllConstant.DT8),
            Container(
              height: 1,
              color: Colors.black26,
            ),

            viewTag("Purchase Date ", "Wed, May 24 2023 - 12:26AM ", AllConstant.CURRENT_LIST_INDEX + AllConstant.DT9),
            Container(
              height: 1,
              color: Colors.black26,
            ),

            //viewTag("Ticket Price ", 'Official Platinum \$ 168.25 Fee \$ 30.30 Tax \$ 3.00 GRAND TOTAL \$ 201.55 ', AllConstant.CURRENT_LIST_INDEX+AllConstant.DT10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text("Ticket Price ", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.black())),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Official Platinum", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: Colors.black54)),
                      viewTag2("\$ 168.25", AllConstant.CURRENT_LIST_INDEX + AllConstant.PRICE1),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Fee", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: Colors.black54)),
                      viewTag2("\$ 3.00", AllConstant.CURRENT_LIST_INDEX + AllConstant.PRICE2),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tax", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: Colors.black54)),
                      viewTag2("\$ 3.55", AllConstant.CURRENT_LIST_INDEX + AllConstant.PRICE3),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("GRAND TOTAL", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: Colors.black54)),
                      viewTag2("\$ 201.55", AllConstant.CURRENT_LIST_INDEX + AllConstant.PRICE4),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),

            Container(
              height: 1,
              color: Colors.black26,
            ),

            viewTag(
                "Terms & Conditions ",
                "Take care of your ticket, as it cannot be replaced if lost, stolen or destroyed, and is valid only for event and seat printed on ticket. This ticket is a revocable license to attend the event listed on the front of the ticket and is subject to the full terms found at www.ticketmaster.com. Such license may be revoked without refund for noncompliance with terms. Unlawful sale or attempted sale prohibited. Tickets obtained from unauthorized sources may be invalid, lost, stolen, or counterfeit and if so, are void. Maximum resale restrictions may apply. NY: if venue seats more than 5,000 persons, ticket may not be resold within 1,500 feet from the physical structure of this place of entertainment under penalty of law. IF an event is not played, ticket may be exchanged for same price seat for either: (a) rescheduled event, if any; or, if applicable, (b) any event designated by the place of entertainment, within 12 months of original event, if available. TIME, OPPONENT, ROSTERS AND DATE SUBJECT TO CHANGE. This ticket may not be used for advertising, promotion or other trade purposes without the written consent of issuer. Applicable taxes are included. Holder assumes all risks, hazards, and dangers occurring before, during or after event, including injury by any cause, or arising from or relating in any way to the risk of contracting a communicable disease or illness (including exposure to COVID-19, a bacteria, virus, or other pathogen capable of causing a communicable disease or illness), however caused or contracted, and hereby waives all claims and potential claims against, the venue, league, participants, clubs, artists, promoters, Ticketmaster, and each of their respective representatives, affiliates and personnel. ",
                AllConstant.CURRENT_LIST_INDEX + AllConstant.DT1),
            Container(
              height: 1,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }

  Padding viewTag(String title, String defaultMessage, String SharedTag, {bool? isBreak, bool? isTitleClickable}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          isTitleClickable == null
              ? Text("$title", style: TextStyle(fontSize: 15, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.black()))
              : FutureBuilder<String>(
                  future: CommonOperation.getSharedData(SharedTag + 1.toString(), "$title", isBreak: isBreak),
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      return GestureDetector(
                        onTap: () {
                          showDialogInput(SharedTag + 1.toString(), "$title");
                        },
                        child: Text(snapshot.data!, style: TextStyle(fontSize: 15, fontFamily: "metropolis", fontWeight: FontWeight.w500, color: AppColor.black())),
                      );
                    }
                  },
                ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder<String>(
            future: CommonOperation.getSharedData(SharedTag, "$defaultMessage", isBreak: isBreak),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                return GestureDetector(
                  onTap: () {
                    showDialogInput(SharedTag, "$defaultMessage");
                  },
                  child: Text(snapshot.data!, style: TextStyle(fontSize: 16, fontFamily: "averta", fontWeight: FontWeight.w400, color: Colors.black54)),
                );
              }
            },
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Padding viewTag2(String defaultMessage, String SharedTag) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<String>(
            future: CommonOperation.getSharedData(SharedTag, "$defaultMessage"),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                return GestureDetector(
                  onTap: () {
                    showDialogInput(SharedTag, "$defaultMessage");
                  },
                  child: Text(snapshot.data!, style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: Colors.black54)),
                );
              }
            },
          ),
        ],
      ),
    );
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
                        //if (inputType != null) initSlide();
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

  void showDialogInputListed(String sec, String defaultTxt, {TextInputType? inputType}) {
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
                        PrefUtil.preferences!.setString(sec, textEditingController.text);
                        textEditingController.text = "";
                        setState(() {});
                        //if (inputType != null) initSlide();
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
