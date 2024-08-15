import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/all_uis/BottomSheetViewtTransferTickets.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';

class BottomSheetViewSelectTickets extends StatefulWidget {
  BottomSheetViewSelectTickets();

  @override
  State<BottomSheetViewSelectTickets> createState() => _BottomSheetVIewState();
}

class _BottomSheetVIewState extends State<BottomSheetViewSelectTickets> {
  var textEditingController = TextEditingController();
  double? seatCardWidth;

  String selected_item = "0 Selected";

  int initGridValue = 0;

  @override
  void initState() {
    getCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text("SELECT TICKETS TO TRANSFER", style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: Colors.black45)),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black12,
              height: 1,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: 5,
            ),
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
                        return Text(snapshot.data!, style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.black54));
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
                              onTap: () {
                                showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.SELECTED_TICKET_COUNT);

                                setState(() {});
                              },
                              child: Text(snapshot.data! + " tickets", style: TextStyle(fontSize: 12, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.black45)),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 300,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: initGridValue,
                  itemBuilder: (BuildContext context, int index) {
                    return getGridItem(index + 1);
                  }),
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
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              //border: Border.all(color: AppColor.blue(), width: 1),
              //borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              //borderRadius: BorderRadius.all(Radius.circular(10.0),),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selected_item,
                        style:
                            TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: int.parse(selected_item.split(" ")[0]) > 0 ? AppColor.colorMain() : Colors.black38)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);

                        showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height - 200,
                            child: BottomSheetViewTransferTickets(),
                          ),
                        );
                      },
                      child: Text("TRANSFER TO >",
                          style: TextStyle(
                              fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: int.parse(selected_item.split(" ")[0]) > 0 ? AppColor.colorMain() : Colors.black38)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ))
      ],
    );
  }

  Future<String> getData() async {
    var secValue = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.SEC);
    var rowValue = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.ROW);

    return "Sec ${secValue ?? "303"}, Row ${rowValue ?? "5"}";
  }

  void showDialogInput(String sec) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Color(0XFFffffff),
                      boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Input Your Value",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      child: Text("OK", style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.green(),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        print("totalAnnualWestController.value");
                        print(textEditingController.text);
                        if (textEditingController.text.toString().isNotEmpty) {
                          if (sec == AllConstant.CURRENT_LIST_INDEX + AllConstant.SELECTED_TICKET_COUNT) {
                            if (int.parse(textEditingController.text.toString()) > 0 && int.parse(textEditingController.text.toString()) < 9) {
                              PrefUtil.preferences!.setString(sec, textEditingController.text);
                              initGridValue = int.parse(textEditingController.text);
                              clearPref();
                              getCount();
                            }
                          } else
                            PrefUtil.preferences!.setString(sec, textEditingController.text);

                          textEditingController.text = "";

                          setState(() {});
                        }
                      }),
                ],
              ),
              //myPledge: model,
            ),
          );
        });
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
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 6,
              offset: Offset(4, 4), // Shadow position
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
                  future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.CARD_value + index.toString(), index.toString()),
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      return GestureDetector(
                        onTap: () {
                          showDialogInput(AllConstant.CURRENT_LIST_INDEX + AllConstant.CARD_value + index.toString());
                        },
                        child: Text("SEAT " + snapshot.data!, style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.white())),
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
                        //showDialogInput(AllConstant.CURRENT_LIST_INDEX+AllConstant.CARD_1);
                        bool valueCircle = !snapshot.data!;
                        PrefUtil.preferences!.setBool(AllConstant.CURRENT_LIST_INDEX + AllConstant.CIRCLE_VALUE + index.toString(), valueCircle);

                        /*if (valueCircle) {
                          String value = await CommonOperation.getSharedData(
                              AllConstant.CURRENT_LIST_INDEX+AllConstant.CARD_value + index.toString(),
                              index.toString());
                          PrefUtil.preferences!.setString(
                              AllConstant.CURRENT_LIST_INDEX+AllConstant.CARD_value + index.toString(), value);
                        } else {
                          PrefUtil.preferences!.remove(
                              AllConstant.CURRENT_LIST_INDEX+AllConstant.CARD_value + index.toString());
                        }*/

                        getCount();
                        setState(() {});
                      },
                      child: snapshot.data == false ? Icon(Icons.circle_outlined, color: Colors.black26) : Icon(Icons.check_circle, color: AppColor.colorMain()),
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
