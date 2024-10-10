import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/all_uis/my_tickets.dart';
import 'package:ticket_master/ios/my_tickets_ios.dart';

import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/widgets_util.dart';

class BottomSheetViewPersonal extends StatefulWidget {
  BottomSheetViewPersonal();

  @override
  State<BottomSheetViewPersonal> createState() => _BottomSheetVIewState();
}

class _BottomSheetVIewState extends State<BottomSheetViewPersonal> {
  var emailUsedController = TextEditingController();
  var firstNameUsedController = TextEditingController();
  var lastNameUsedController = TextEditingController();
  var noteUsedController = TextEditingController();

  String ticketCount = "0";
  String ticketTitle = "";

  bool transferButtonLoading = false;

  @override
  void initState() {
    emailUsedController.text = PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.EMAIL) ?? "";
    firstNameUsedController.text = PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.FNAME) ?? "";
    lastNameUsedController.text = PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.LNAME) ?? "";
    noteUsedController.text = PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.NOTE) ?? "";
    getCount();
    super.initState();
  }

  @override
  void dispose() {
    saveShared();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 580,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  getCount();
                },
                child: Text("TRANSFER TICKETS",
                    style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: Colors.black45)),
              ),
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(ticketCount.toString() + " Tickets Selected",
                        style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.black38)),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Sec ", style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.black38)),
                        FutureBuilder<String>(
                          future: getData(1),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              return Text(snapshot.data!,
                                  style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.black87));
                            }
                          },
                        ),
                        Text(", Row ",
                            style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.black38)),
                        FutureBuilder<String>(
                          future: getData(2),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              return Text(snapshot.data!,
                                  style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.black87));
                            }
                          },
                        ),
                        Text(", Seat ",
                            style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.black38)),
                        FutureBuilder<String>(
                          future: CommonOperation.getSortValue(ticketTitle),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              return Text(snapshot.data!,
                                  style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: Colors.black54));
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 380,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("First Name",
                          style: TextStyle(fontSize: 15, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.black)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Color(0XFFffffff),
                          boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: TextField(
                            controller: firstNameUsedController,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "First Name",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),

                      ///Last--------------------------------
                      ///Last--------------------------------
                      SizedBox(
                        height: 15,
                      ),
                      Text("Last Name", style: TextStyle(fontSize: 15, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.black)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Color(0XFFffffff),
                          boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: TextField(
                            controller: lastNameUsedController,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Last Name",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),

                      ///Email--------------------------------
                      ///Email--------------------------------
                      SizedBox(
                        height: 15,
                      ),
                      Text("Email or Mobile Number",
                          style: TextStyle(fontSize: 15, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.black)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Color(0XFFffffff),
                          boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: TextField(
                            controller: emailUsedController,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email or Mobile Number",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),

                      ///Note--------------------------------
                      ///Note--------------------------------
                      SizedBox(
                        height: 15,
                      ),
                      Text("Note", style: TextStyle(fontSize: 15, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.black)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        constraints: BoxConstraints(maxHeight: 100),
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Color(0XFFffffff),
                          boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextField(
                              controller: noteUsedController,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Note",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                      /*Container(
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: Color(0XFFffffff),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0X95E9EBF0),
                                  blurRadius: 2,
                                  spreadRadius: 2)
                            ],
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextField(
                              controller: noteUsedController,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Note",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),*/
                    ],
                  ),
                ),
              ),
              Container(
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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            saveShared();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: AppColor.colorMain(),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Back",
                                  style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: AppColor.colorMain()))
                            ],
                          ),
                        ),
                        transferButtonLoading == true
                            ? Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: CircularProgressIndicator(),
                              )
                            : TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(0), // Remove any extra padding
                                  backgroundColor: AppColor.colorMain(), // Background color
                                  foregroundColor: Colors.white, // Text color
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                                onLongPress: () {
                                  sowDialog();
                                },
                                onPressed: () async {
                                  setState(() {
                                    transferButtonLoading = true;
                                  });
                                  await Future.delayed(const Duration(seconds: 2), () {});

                                  transferButtonLoading = false;
                                  Navigator.of(context).pop();
                                  saveShared();
                                  if (Platform.isAndroid)
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MyTicketsNewView(ticketCount, ticketTitle)),
                                    );
                                  else
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MyTicketsiOS(ticketCount, ticketTitle)),
                                    );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Transfer ${ticketCount} Tickets",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "metropolis",
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getData(int temp) async {
    var secValue = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.SEC);
    var rowValue = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.ROW);

    var value1 = secValue == null ? "303" : secValue;
    var value2 = rowValue == null ? "5" : rowValue;

    if (temp == 1) {
      return value1;
    } else
      return value2;
  }

  /*Future<String> getDataSeat() async {
    var row3Value = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX+AllConstant.CARD_1);
    var row4Value = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX+AllConstant.CARD_2);
    print(row3Value);

    return row3Value == null || row4Value == null
        ? "3,4"
        : row3Value + ", " + row4Value;
  }*/

  void saveShared() {
    PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.FNAME, firstNameUsedController.text);
    PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.LNAME, lastNameUsedController.text);
    PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.EMAIL, emailUsedController.text);
    PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.NOTE, noteUsedController.text);
  }

  Future<void> getCount() async {
    int value = await CommonOperation.getTicketCount();
    String getTicketTitle = await CommonOperation.getTicketTitle();

    ticketCount = value.toString();
    ticketTitle = getTicketTitle;

    setState(() {});
  }

  void sowDialog() {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      /*contentPadding: EdgeInsets.zero,*/
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: DialogDetails(ticketCount),
    );
    showDialog(context: context, builder: (BuildContext context) => errorDialog);
  }
}

class DialogDetails extends StatefulWidget {
  String ticketCount;

  DialogDetails(this.ticketCount);

  @override
  State<DialogDetails> createState() => _DialogDetailsState();
}

class _DialogDetailsState extends State<DialogDetails> {
  var textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double boxHeight = 10;
    return Container(
      height: 280,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: boxHeight,
            ),
            Text(
              'Oops! We are experiencing technical difficulties.',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, height: 1.2, letterSpacing: 0.6, fontSize: 20),
            ),
            SizedBox(
              height: boxHeight,
            ),
            Text(
              "We apologise - we weren't able to complete your request.",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, letterSpacing: 0.7, height: 1.5, fontSize: 14),
            ),
            SizedBox(
              height: boxHeight,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.red.shade50,
                boxShadow: [
                  BoxShadow(color: Colors.red, spreadRadius: 1),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                        width: 60,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Image.asset("assets/images/alert.png"),
                        )),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showDialogInput(AllConstant.DIALOG_TICKET_COUNT, "0", inputType: TextInputType.number);
                          setState(() {});
                        },
                        child: Text(
                          'Due to the client purchasing restrictions in place for these exchanged seats, you are currently not permitted to split. Please transfer (${PrefUtil.preferences!.getString(AllConstant.DIALOG_TICKET_COUNT) ?? 0}) tickets at once, we apologize for the inconvenience and appreciate your patience.',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: boxHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    backgroundColor: AppColor.colorMain(),
                    // Background color
                    foregroundColor: Colors.white,
                    // Text color
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    fixedSize: const Size(150, 40), // minWidth and height combined
                  ),
                  onLongPress: () {},
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "metropolis",
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
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
                    onPressed: () async {
                      Navigator.of(context).pop();

                      if (textEditingController.text.toString().isNotEmpty) {
                        if (inputType != null) {
                          if (int.parse(textEditingController.text) < 1) return;
                        }
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
