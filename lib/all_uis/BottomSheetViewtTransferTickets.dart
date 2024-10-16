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
            Text("Forward To", style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w300, color: Colors.black87)),
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
                    border: Border.all(color: AppColor.officialBlueProfile),
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
                            Text("Select From Contacts".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 12,
                                    decorationThickness: 2,
                                    fontFamily: "metropolis",
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.officialBlueProfile)),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.perm_contact_calendar_outlined,
                              color: AppColor.officialBlueProfile,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  height: 40.0,
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
                    border: Border.all(color: AppColor.officialBlueProfile),
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
                            Text("Manually Enter A Recipient".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "metropolis",
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.officialBlueProfile)),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.add_circle_outline,
                              color: AppColor.officialBlueProfile,
                              size: 25,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  height: 40.0,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 60,
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
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                height: 60.0,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Transfer Tickets Via Email or\n Text Message",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.w800, color: Colors.black.withOpacity(0.6))),
            SizedBox(
              height: 5,
            ),
            Text("Select an Email or mobile number to\n transfer tickets to your recipient.",
                style: TextStyle(fontSize: 13, fontFamily: "metropolis", fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.8))),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
