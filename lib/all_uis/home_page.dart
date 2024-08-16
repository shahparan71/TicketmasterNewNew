import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/main_landing_screen.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/widgets_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? filePath;
  var textEditingController = TextEditingController();

  bool taxExeShowHide = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: homeMain(),
    );
  }

  homeMain() {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height - 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: int.parse(PrefUtil.preferences!.getString(AllConstant.NUMBER_OF_LIST_ITEM_COUNT) ?? "1"),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: 220,
                    child: Stack(
                      children: [
                        //Jimmy Kimmel LV Bowl Presented By Stifel
                        FutureBuilder<File?>(
                          future: CommonOperation.getImagePath(index.toString() + AllConstant.IMAGE_PATH),
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
                                    ],
                                  )
                                : Stack(
                                    children: [
                                      Image.asset(
                                        "assets/images/album.jpg",
                                        fit: BoxFit.cover,
                                        height: 220.0,
                                        width: MediaQuery.of(context).size.width - 10,
                                      ),
                                      Image.asset(
                                        "assets/images/shadow.png",
                                        fit: BoxFit.cover,
                                        height: 220.0,
                                        width: MediaQuery.of(context).size.width - 10,
                                      ),
                                    ],
                                  );
                          },
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width - 20,
                          height: 220,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: GestureDetector(
                                  onTap: () {
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
                                                    onTap: () {
                                                      pickImage(1, index.toString() + AllConstant.IMAGE_PATH);
                                                    },
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        pickImage(2, index.toString() + AllConstant.IMAGE_PATH);
                                                      },
                                                      child: Icon(Icons.file_copy))
                                                ],
                                              ),
                                              //myPledge: model,
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    color: Colors.black12,
                                  ),
                                )),
                                Flexible(
                                    child: GestureDetector(
                                  onTap: () {
                                    AllConstant.CURRENT_LIST_INDEX = index.toString();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MainLandingScreen()),
                                    );
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    color: Colors.black12,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),

                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Container(
                                height: 155,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    PrefUtil.preferences!.getBool(index.toString() + AllConstant.TAX_EMP) == null || PrefUtil.preferences!.getBool(index.toString() + AllConstant.TAX_EMP) == false
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                PrefUtil.preferences!.setBool(index.toString() + AllConstant.TAX_EMP, true);
                                              });
                                            },
                                            child: Image.asset(
                                              'assets/images/tax_exe.png',
                                              height: 20,
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    PrefUtil.preferences!.getBool(index.toString() + AllConstant.IS_MULTILINE) == null ||
                                            PrefUtil.preferences!.getBool(index.toString() + AllConstant.IS_MULTILINE) == false
                                        ? FutureBuilder<String>(
                                            future: CommonOperation.getSharedData(index.toString() + AllConstant.IAMGE_BIG_TEXT, "Taylor Swift | The Eras Tour"),
                                            builder: (context, AsyncSnapshot<String> snapshot) {
                                              if (!snapshot.hasData) {
                                                return Container();
                                              } else {
                                                return GestureDetector(
                                                  onTap: () async {
                                                    showDialogInput(index.toString() + AllConstant.IAMGE_BIG_TEXT, "Taylor Swift | The Eras Tour");
                                                  },
                                                  child: Container(
                                                    child: Text(snapshot.data!,
                                                        maxLines: 1,
                                                        textAlign: TextAlign.start,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontSize: PrefUtil.preferences!.getDouble(index.toString() + AllConstant.IncreaseDecreaseFontMain) ?? 18,
                                                            fontFamily: "metropolis",
                                                            fontWeight: CommonOperation.getFontWeight(),
                                                            color: AppColor.white())),
                                                  ),
                                                );
                                              }
                                            },
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    FutureBuilder<String>(
                                      future: CommonOperation.getSharedData(index.toString() + AllConstant.IAMGE_BIG_TEXT_2, "Taylor Swift | The Eras Tour"),
                                      builder: (context, AsyncSnapshot<String> snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container();
                                        } else {
                                          return GestureDetector(
                                            onTap: () async {
                                              showDialogInput(index.toString() + AllConstant.IAMGE_BIG_TEXT_2, "Taylor Swift | The Eras Tour");
                                            },
                                            child: Container(
                                              child: Text(snapshot.data!,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: PrefUtil.preferences!.getDouble(index.toString() + AllConstant.IncreaseDecreaseFontMain) ?? 18,
                                                      fontFamily: "metropolis",
                                                      fontWeight: CommonOperation.getFontWeight(),
                                                      color: AppColor.white())),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width - 100,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          FutureBuilder<String>(
                                            future: CommonOperation.getSharedData(index.toString() + AllConstant.DATE, "Sat, Dec 18, 4:30pm . SofFi Stadium"),
                                            builder: (context, AsyncSnapshot<String> snapshot) {
                                              if (!snapshot.hasData) {
                                                return Container();
                                              } else {
                                                return GestureDetector(
                                                  onTap: () async {
                                                    showDialogInput(index.toString() + AllConstant.DATE, "Sat, Dec 18, 4:30pm . SofFi Stadium");
                                                  },
                                                  child: Text(snapshot.data!,
                                                      textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: AppColor.white())),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/Landing_Icon.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        FutureBuilder<String>(
                                          future: CommonOperation.getSharedData(index.toString() + AllConstant.SELECTED_TICKET_COUNT, "6"),
                                          builder: (context, AsyncSnapshot<String> snapshot) {
                                            if (!snapshot.hasData) {
                                              return Container();
                                            } else {
                                              return GestureDetector(
                                                onTap: () {
                                                  showDialogInput(index.toString() + AllConstant.SELECTED_TICKET_COUNT, "6", inputType: TextInputType.number);

                                                  setState(() {});
                                                },
                                                child: Text(snapshot.data! + " tickets", style: TextStyle(fontSize: 12, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
                                              );
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Image.asset(
                                          'assets/images/resale.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        FutureBuilder<String>(
                                          future: CommonOperation.getSharedData(index.toString() + AllConstant.SELECTED_LISTED, "0"),
                                          builder: (context, AsyncSnapshot<String> snapshot) {
                                            if (!snapshot.hasData) {
                                              return Container();
                                            } else {
                                              return GestureDetector(
                                                onTap: () {
                                                  showDialogInputListed(index.toString() + AllConstant.SELECTED_LISTED, "0", inputType: TextInputType.number);

                                                  setState(() {});
                                                },
                                                child: Text(snapshot.data! + " listed", style: TextStyle(fontSize: 12, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> pickImage(int i, String path) async {
    Navigator.of(context).pop();
    final pickedFile = await ImagePicker().pickImage(
      source: i == 1 ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
    );
    filePath = pickedFile!.path;
    print("filePath");
    print(filePath);
    PrefUtil.preferences!.setString(path, filePath!);
    setState(() {});
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
                        /*if (inputType != null) {
                          if (int.parse(textEditingController.text) < -1 ||
                              int.parse(textEditingController.text) > 10)
                            return;
                        }*/
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
