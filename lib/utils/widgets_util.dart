import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/custom_dialog.dart';
import 'package:ticket_master/utils/future_stateful_widget.dart';

class DiscoverImageAndroid extends StatefulWidget {
  @override
  State<DiscoverImageAndroid> createState() => _DiscoverImageAndroidState();
}

class _DiscoverImageAndroidState extends State<DiscoverImageAndroid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 120,
            child: Stack(
              children: [
                //Jimmy Kimmel LV Bowl Presented By Stifel
                FutureBuilder<File?>(
                  future: CommonOperation.getImagePath(AllConstant.DISCOVER_IMAGE_PATH),
                  builder: (context, AsyncSnapshot<File?> snapshot) {
                    return snapshot.data != null
                        ? Stack(
                            children: [
                              Container(
                                child: GestureDetector(
                                  onTap: () async {
                                    pickImageDiscover();
                                  },
                                  child: Image.file(
                                    snapshot.data!,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width / 2,
                                    height: double.infinity,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Stack(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  pickImageDiscover();
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset(
                                      "assets/images/discover_person.png",
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                      width: MediaQuery.of(context).size.width / 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pickImage(int i, String path, BuildContext context) async {
    Navigator.of(context).pop();
    final pickedFile = await ImagePicker().pickImage(
      source: i == 1 ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
    );
    var filePath = pickedFile!.path;
    print("filePath");
    print(filePath);
    PrefUtil.preferences!.setString(path, filePath);

    setState(() {});
  }

  pickImageDiscover() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.camera_alt,
                    ),
                    onTap: () async {
                      pickImage(1, AllConstant.DISCOVER_IMAGE_PATH, context);
                    },
                  ),
                  GestureDetector(
                      onTap: () async {
                        pickImage(2, AllConstant.DISCOVER_IMAGE_PATH, context);
                      },
                      child: Icon(Icons.file_copy))
                ],
              ),
              //myPledge: model,
            ),
          );
        });
  }
}

class WidgetsUtil {
  static Widget CustomElevatedButton({String? buttonText, Function? function, Color? color, FontWeight? fontWeight}) {
    return SizedBox(
      height: 50.0,
      child: ElevatedButton(
        child: Text("$buttonText",
            style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: fontWeight ?? FontWeight.normal, color: Colors.white)),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(color ?? AppColor.colorMain()),
            backgroundColor: MaterialStateProperty.all<Color>(color ?? AppColor.colorMain()),
            elevation: MaterialStateProperty.all(0.0),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)), /*side: BorderSide(color: Colors.red)*/
            ))),
        onPressed: () {
          function!("$buttonText");
        },
      ),
    );
  }

  static Widget inputBoxForAll(String defaultTxt, String sec, TextEditingController textEditingController, {TextInputType? inputType}) {
    return Container(
      height: CommonOperation.isNumeric(defaultTxt) ? 50 : 100,
      decoration: BoxDecoration(
        color: Color(0XFFffffff),
        boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: FutureBuilder<String>(
        future: CommonOperation.getSharedData(sec, defaultTxt),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return TextField(
              controller: textEditingController,
              maxLines: CommonOperation.isNumeric(defaultTxt) ? 1 : 3,
              keyboardType: inputType == null ? TextInputType.text : inputType,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: snapshot.data!,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }
}

class DiscoverImageIOS extends StatefulWidget {
  @override
  State<DiscoverImageIOS> createState() => _DiscoverImageIOSState();
}

class _DiscoverImageIOSState extends State<DiscoverImageIOS> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Stack(
        children: [
          //Jimmy Kimmel LV Bowl Presented By Stifel
          FutureBuilder<File?>(
            future: CommonOperation.getImagePath(AllConstant.DISCOVER_IMAGE_PATH),
            builder: (context, AsyncSnapshot<File?> snapshot) {
              return snapshot.data != null
                  ? Stack(
                      children: [
                        GestureDetector(
                          child: Image.file(
                            snapshot.data!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          onTap: () async {
                            pickImageDiscover();
                          },
                        ),
                      ],
                    )
                  : Stack(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            pickImageDiscover();
                          },
                          child: Image.asset(
                            "assets/images/discover_person.png",
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }

  pickImage(int i, String path, BuildContext context) async {
    Navigator.of(context).pop();
    final pickedFile = await ImagePicker().pickImage(
      source: i == 1 ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
    );
    var filePath = pickedFile!.path;
    print("filePath");
    print(filePath);
    PrefUtil.preferences!.setString(path, filePath);

    setState(() {});
  }

  pickImageDiscover() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.camera_alt,
                    ),
                    onTap: () async {
                      pickImage(1, AllConstant.DISCOVER_IMAGE_PATH, context);
                    },
                  ),
                  GestureDetector(
                      onTap: () async {
                        pickImage(2, AllConstant.DISCOVER_IMAGE_PATH, context);
                      },
                      child: Icon(Icons.file_copy))
                ],
              ),
              //myPledge: model,
            ),
          );
        });
  }
}

class SecRowSeatJustShow extends StatefulWidget {
  String ticketCount;
  String seatRange;

  SecRowSeatJustShow(this.ticketCount, this.seatRange);

  @override
  State<SecRowSeatJustShow> createState() => _SecRowSeatJustShowState();
}

class _SecRowSeatJustShowState extends State<SecRowSeatJustShow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color:  AppColor.colorMain(),

        //BorderSide(color: AppColor.colorPrimary(), width: 0.5, style: BorderStyle.solid
      ),
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("SEC",
                      style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight2(), color: AppColor.white)),
                  SizedBox(
                    height: 5,
                  ),
                  FutureBuilder<String>(
                    future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.SEC, "407A"),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return Text(snapshot.data!, style: CommonOperation.getFontThinkNessNewDesign());
                      }
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Text("ROW",
                      style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight2(), color: AppColor.white)),
                  SizedBox(
                    height: 5,
                  ),
                  FutureBuilder<String>(
                    future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.ROW, "5"),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return Text(snapshot.data!, style: CommonOperation.getFontThinkNessNewDesign());
                      }
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Text("SEAT",
                      style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight2(), color: AppColor.white)),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${int.parse(widget.ticketCount) == 0 ? "0" : widget.seatRange}", style: CommonOperation.getFontThinkNessNewDesign())
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SecRowSeat extends StatefulWidget {
  int current;

  SecRowSeat(this.current);

  @override
  State<SecRowSeat> createState() => _SecRowSeatState();
}

class _SecRowSeatState extends State<SecRowSeat> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String? result = await CustomInputDialog.showInputDialog(
          context: context,
          defaultTxt: "2166e5",
          key: AllConstant.CURRENT_LIST_INDEX + AllConstant.COLOR_MAIN,
        );
        if (result != null) {
          PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.COLOR_MAIN, result);
          setState(() {});
        } else {
          print("Dialog was canceled");
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.colorMain(),

          //BorderSide(color: AppColor.colorPrimary(), width: 0.5, style: BorderStyle.solid
        ),
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("SEC",
                        style:
                            TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight2(), color: AppColor.white)),
                    SizedBox(
                      height: 5,
                    ),
                    CustomBuilderWidget(
                        keyValue: AllConstant.CURRENT_LIST_INDEX + AllConstant.SEC,
                        defaultValue: "407A",
                        textStyle: CommonOperation.getFontThinkNessNewDesign()),
                  ],
                ),
                Column(
                  children: [
                    Text("ROW",
                        style:
                            TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight2(), color: AppColor.white)),
                    SizedBox(
                      height: 5,
                    ),
                    CustomBuilderWidget(
                        keyValue: AllConstant.CURRENT_LIST_INDEX + AllConstant.ROW,
                        defaultValue: "5",
                        textStyle: CommonOperation.getFontThinkNessNewDesign()),
                  ],
                ),
                Column(
                  children: [
                    Text("SEAT",
                        style:
                            TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: CommonOperation.getFontWeight2(), color: AppColor.white)),
                    SizedBox(
                      height: 5,
                    ),
                    CustomBuilderWidget(
                        keyValue: AllConstant.CURRENT_LIST_INDEX + AllConstant.SEAT + widget.current.toString(),
                        defaultValue: "${widget.current.toString()}",
                        textStyle: CommonOperation.getFontThinkNessNewDesign()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
