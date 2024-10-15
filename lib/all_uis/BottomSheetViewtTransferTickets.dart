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
  State<BottomSheetViewTransferTickets> createState() => _BottomSheetVIewState();
}

class _BottomSheetVIewState extends State<BottomSheetViewTransferTickets> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text("TRANSFER TO", style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: Colors.black45)),
            SizedBox(
              height: 10,
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
                    boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
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
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColor.colorMain(),
                                    decorationThickness: 2,
                                    fontFamily: "metropolis",
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.officialBlue)),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.perm_contact_calendar_outlined,
                              color: AppColor.officialBlue,
                              size: 25,
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
                    boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
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
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColor.colorMain(),
                                    decorationThickness: 2,
                                    fontFamily: "metropolis",
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.officialBlue)),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.add_circle_outline,
                              color: AppColor.officialBlue,
                              size: 25,
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
                style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.w800, color: Colors.black54)),
            SizedBox(
              height: 5,
            ),
            Text("Select an Email or mobile number to\n transfer tickets to your recipient.",
                style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w600, color: Colors.black54)),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
