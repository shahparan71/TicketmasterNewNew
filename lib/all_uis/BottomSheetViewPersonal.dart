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
import 'package:ticket_master/utils/custom_dialog.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 450,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Transfer Tickets",
                            style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: Colors.black87)),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Text(ticketCount.toString() + " Tickets Selected",
                            style: TextStyle(fontSize: 15, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.black87)),
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Section ",
                                style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.black38)),
                            FutureBuilder<String>(
                              future: getData(1),
                              builder: (context, AsyncSnapshot<String> snapshot) {
                                if (!snapshot.hasData) {
                                  return Container();
                                } else {
                                  return Text(snapshot.data!,
                                      style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.w600, color: Colors.black87));
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
                                      style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.w600, color: Colors.black87));
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
                                      style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.w600, color: Colors.black87));
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("First Name", style: CommonOperation.getFontStyleProfielBottomSheet()),
                    SizedBox(
                      height: 5,
                    ),
                    getInputFields(firstNameUsedController, "First name"),

                    ///Last--------------------------------
                    ///Last--------------------------------
                    SizedBox(
                      height: 30,
                    ),
                    Text("Last Name", style: CommonOperation.getFontStyleProfielBottomSheet()),
                    SizedBox(
                      height: 5,
                    ),
                    getInputFields(lastNameUsedController, "Last name"),

                    ///Email--------------------------------
                    ///Email--------------------------------
                    SizedBox(
                      height: 30,
                    ),
                    Text("Email or Mobile Number", style: CommonOperation.getFontStyleProfielBottomSheet()),
                    SizedBox(
                      height: 5,
                    ),
                    getInputFields(emailUsedController, "Email or Mobile Number"),

                    ///Note--------------------------------
                    ///Note--------------------------------
                    SizedBox(
                      height: 30,
                    ),
                    Text("Note", style: CommonOperation.getFontStyleProfielBottomSheet()),
                    SizedBox(
                      height: 5,
                    ),

                    Container(
                      constraints: BoxConstraints(maxHeight: 100),
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black54, width: 0.5),
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
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 7),
                              hintText: "Max. 200 Characters",
                              hintStyle: CommonOperation.getFontStyleProfielBottomSheet(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                color: AppColor.lightBlue2,
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
                        onTap: () async {
                          Navigator.of(context).pop();
                          saveShared();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: AppColor.officialBlue,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Back",
                                style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.officialBlue))
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
                                  borderRadius: BorderRadius.all(Radius.circular(2)),
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
                                    fontSize: 16,
                                    fontFamily: "metropolis",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getData(int temp) async {
    var secValue = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.SEC);
    var rowValue = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.ROW);

    var value1 = secValue == null ? "407A" : secValue;
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

  Widget getInputFields(TextEditingController controller, String s) {
    return Container(
      height: 40, // Adjust this value as needed to reduce the height
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        // Ensures text is vertically centered
        decoration: InputDecoration(
          border: InputBorder.none,
          // Remove default border
          isDense: true,
          // Reduces the vertical space
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          // Remove vertical padding for better centering

          hintText: "${s}",
          hintStyle: CommonOperation.getFontStyleProfielBottomSheet(),
          suffixIcon: Icon(
            Icons.cancel_outlined,
            size: 18,
            color: Colors.black38,
          ),
          // Border when the TextField is not focused (inactive) - 4-sided border
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
            borderRadius: BorderRadius.circular(2), // Adjust as needed
          ),

          // Border when the TextField is focused (active) - 4-sided border
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(2), // Adjust as needed
          ),
        ),
      ),
    );
  }
}

class DialogDetails extends StatefulWidget {
  String ticketCount;

  DialogDetails(this.ticketCount);

  @override
  State<DialogDetails> createState() => _DialogDetailsState();
}

class _DialogDetailsState extends State<DialogDetails> {
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
                        onTap: () async {
                          String? result = await CustomInputDialog.showInputDialog(
                              context: context, defaultTxt: "0", key: AllConstant.DIALOG_TICKET_COUNT, textInputType: TextInputType.number);
                          if (result != null) {
                            if (int.parse(result) < 1) return;

                            PrefUtil.preferences!.setString(
                              AllConstant.DIALOG_TICKET_COUNT,
                              result,
                            );
                            setState(() {});
                          } else {
                            print("Dialog was canceled");
                          }

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
}
