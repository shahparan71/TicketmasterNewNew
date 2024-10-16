import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/all_uis/BottomSheetViewtTransferTickets.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

class BottomSheetViewSelectTickets extends StatefulWidget {
  BottomSheetViewSelectTickets();

  @override
  State<BottomSheetViewSelectTickets> createState() => _BottomSheetVIewState();
}

class _BottomSheetVIewState extends State<BottomSheetViewSelectTickets> {
  String selected_item = "0 Selected";
  int initGridValue = 0;

  @override
  void initState() {
    getCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text("SELECT TICKETS TO TRANSFER",
                  style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: Colors.black45)),

              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FutureBuilder<String>(
                      future: getData(),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          return Text(snapshot.data!,
                              style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.black87));
                        }
                      },
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/TicketTransfer.png',
                          width: 20,
                          height: 20,
                        ),
                        FutureBuilder<String>(
                          future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.SELECTED_TICKET_COUNT, "6"),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              return GestureDetector(
                                onTap: () async {
                                  String? result = await CustomInputDialog.showInputDialog(
                                      context: context, defaultTxt: "1", key: AllConstant.CURRENT_LIST_INDEX + AllConstant.SELECTED_TICKET_COUNT);
                                  if (result != null) {
                                    if (int.parse(result) > 0 && int.parse(result) < 9) {
                                      PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.SELECTED_TICKET_COUNT, result);
                                      initGridValue = int.parse(result);
                                      clearPref();
                                      getCount();
                                      setState(() {});
                                    }
                                  } else {
                                    print("Dialog was canceled");
                                  }

                                  setState(() {});
                                },
                                child: Text(snapshot.data! + " tickets",
                                    style: TextStyle(fontSize: 12, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.black45)),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                height: 220,
                child: Center(
                  child: GridView.builder(
                      padding: EdgeInsets.only(top: 20), // Remove any padding
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemCount: initGridValue,
                      itemBuilder: (BuildContext context, int index) {
                        return getGridItem(index);
                      }),
                ),
              ),
              //getGridItem(),

              SizedBox(
                height: 30,
              ),
            ],
          ),
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                //border: Border.all(color: AppColor.blue(), width: 1),
                //borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                //borderRadius: BorderRadius.all(Radius.circular(10.0),),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selected_item,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "metropolis",
                              fontWeight: FontWeight.bold,
                              color: int.parse(selected_item.split(" ")[0]) > 0 ? Colors.black38 : Colors.black38)),
                      GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                          //_showBottomSheet(context);
                          showMaterialModalBottomSheet(
                            isDismissible: false,
                            // Prevents closing by tapping outside
                            enableDrag: false,
                            context: context,
                            builder: (context) => Container(
                              height: MediaQuery.of(context).size.height - 450,
                              child: BottomSheetViewTransferTickets(),
                            ),
                          );
                          /*showModalBottomSheet(
                            isDismissible: false,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => Container(
                              height: MediaQuery.of(context).size.height - 450,
                              child: BottomSheetViewTransferTickets(),
                            ),
                          );*/
                        },
                        child: Text("Transfer To >",
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: "metropolis",
                                fontWeight: FontWeight.normal,
                                color: int.parse(selected_item.split(" ")[0]) > 0 ? AppColor.officialBlue : Colors.black38)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }

  Future<String> getData() async {
    var secValue = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.SEC);
    var rowValue = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.ROW);

    return "Sec ${secValue ?? "407A"}, Row ${rowValue ?? "5"}";
  }

  Future<void> getCount() async {
    var value = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.SELECTED_TICKET_COUNT);
    if (value != null) {
      initGridValue = int.parse(value);
    } else
      initGridValue = 6;

    int valueTicketCount = await CommonOperation.getTicketCount();

    selected_item = valueTicketCount.toString() + " Selected";

    setState(() {});
  }

  Future<void> clearPref() async {
    Set<String> keys = await PrefUtil.preferences!.getKeys();

    print(keys);

    for (var e in keys) {
      print(e);
      if (e.contains("card") || e.contains("circle")) {
        PrefUtil.preferences!.remove(e);
      }
      //code
    }
    setState(() {});
  }

  Widget getGridItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(2, 2), // Shadow position
            ),
          ],
          //border: Border.all(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: 30,
              decoration: BoxDecoration(
                color: AppColor.colorMain(),
                border: Border.all(color: AppColor.colorMain(), width: 1),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              ),
              child: Center(
                child: FutureBuilder<String>(
                  future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.SEAT + index.toString(), index.toString()),
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      return GestureDetector(
                        onTap: () async {},
                        child: Text("SEAT " + snapshot.data!,
                            style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.white)),
                      );
                    }
                  },
                ),
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: FutureBuilder<bool>(
                future: CommonOperation.getSharedDataBool(AllConstant.CURRENT_LIST_INDEX + AllConstant.CIRCLE_VALUE + index.toString(), false),
                builder: (context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData == null) {
                    return Container();
                  } else {
                    return GestureDetector(
                      onTap: () async {
                        bool valueCircle = !snapshot.data!;
                        PrefUtil.preferences!.setBool(AllConstant.CURRENT_LIST_INDEX + AllConstant.CIRCLE_VALUE + index.toString(), valueCircle);

                        getCount();
                        setState(() {});
                      },
                      child: snapshot.data == false
                          ? Icon(Icons.check_box_outline_blank, color: Colors.black26)
                          : Icon(Icons.check_box, color: AppColor.officialBlue),
                    );
                  }
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
