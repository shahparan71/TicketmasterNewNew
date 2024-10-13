import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/all_uis/BottomSheetViewPersonal.dart';
import 'package:ticket_master/utils/AppColor.dart';

class BottomSheetViewTransferTickets extends StatefulWidget {
  BottomSheetViewTransferTickets();

  @override
  State<BottomSheetViewTransferTickets> createState() =>
      _BottomSheetVIewState();
}

class _BottomSheetVIewState extends State<BottomSheetViewTransferTickets> {
  @override
  void initState() {
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
            Text("TRANSFER TO",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "metropolis",
                    fontWeight: FontWeight.bold,
                    color: Colors.black45)),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black12,
              height: 1,
              width: MediaQuery.of(context).size.width,
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => BottomSheetViewPersonal(),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0XFFffffff),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0X95E9EBF0),
                          blurRadius: 2,
                          spreadRadius: 2)
                    ],
                    border: Border.all(color: AppColor.colorMain()),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Select From Contacts",
                                style: TextStyle(
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColor.colorMain(),
                                    decorationThickness: 2,
                                    fontFamily: "metropolis",
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.colorMain())),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.perm_contact_calendar_outlined,
                              color: AppColor.colorMain(),
                              size: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  height: 48.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => BottomSheetViewPersonal(),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0XFFffffff),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0X95E9EBF0),
                          blurRadius: 2,
                          spreadRadius: 2)
                    ],
                    border: Border.all(color: AppColor.colorMain()),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Manually Enter A Recipient",
                                style: TextStyle(
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColor.colorMain(),
                                    decorationThickness: 2,
                                    fontFamily: "metropolis",
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.colorMain())),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.add_circle_outline,
                              color: AppColor.colorMain(),
                              size: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  height: 48.0,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  /*boxShadow: [
                    BoxShadow(
                        color: Color(0X95E9EBF0),
                        blurRadius: 2,
                        spreadRadius: 2)
                  ],*/
                  //border: Border.all(color: AppColor.blue()),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                    child: Image.asset(
                      "assets/images/paper-plane.png",
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                height: 80.0,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Transfer Tickets Via Email or Text Message",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "metropolis",
                    fontWeight: FontWeight.w800,
                    color: Colors.black54)),
            SizedBox(
              height: 5,
            ),
            Text(
                "Select an Email or mobile number to\n transfer tickets to your recipient.",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "metropolis",
                    fontWeight: FontWeight.w600,
                    color: Colors.black54)),
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
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pop();
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
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "metropolis",
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.colorMain()))
                        ],
                      ),
                    ),
                    Container()
                  ],
                ),
              ),
            ),
          ),
        ))
      ],
    );
  }
}
