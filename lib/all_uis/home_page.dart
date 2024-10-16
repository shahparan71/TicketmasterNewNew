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
import 'package:ticket_master/utils/main_landing_screen_ios.dart';
import 'package:ticket_master/utils/widgets_util.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  String? filePath;
  bool taxExeShowHide = false;
  TabController? tabController;

  var is1Active = true;

  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            height: 60,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            is1Active = !is1Active;
                          });
                        },
                        child: Container(
                          height: 50,
                          color: AppColor.colorMain(),
                          child: Center(
                            child: FutureBuilder<String>(
                              future: CommonOperation.getSharedData(AllConstant.NUMBER_OF_LIST_ITEM_COUNT, "1"),
                              builder: (context, AsyncSnapshot<String> snapshot) {
                                if (!snapshot.hasData) {
                                  return Container();
                                } else {
                                  return Container(
                                    child: Text("UPCOMING (${snapshot.data!})",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "metropolis",
                                            fontWeight: CommonOperation.getFontWeight(),
                                            color: AppColor.white)),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            is1Active = !is1Active;
                          });
                        },
                        child: Container(
                          height: 50,
                          color: AppColor.colorMain(),
                          child: Center(
                            child: Text(
                              "PAST (0)",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4,
                        color: is1Active ? Colors.white : AppColor.colorMain(),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        height: 4,
                        color: is1Active ? AppColor.colorMain() : Colors.white,
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 200,
            child: is1Active ? buildContainerTab1(context) : Container(),
          ),
        ],
      ),
    );
  }

  Container buildContainerTab1(BuildContext context) {
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
                                  onTap: () async {
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
                                                      pickImage(1, index.toString() + AllConstant.IMAGE_PATH);
                                                    },
                                                  ),
                                                  GestureDetector(
                                                      onTap: () async {
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
                                  onTap: () async {
                                    AllConstant.CURRENT_LIST_INDEX = index.toString();
                                    if (Platform.isIOS) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MainLandingScreenIOS()),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MainLandingScreen()),
                                      );
                                    }
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
                                    PrefUtil.preferences!.getBool(index.toString() + AllConstant.TAX_EMP) == null ||
                                            PrefUtil.preferences!.getBool(index.toString() + AllConstant.TAX_EMP) == false
                                        ? GestureDetector(
                                            onTap: () async {
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
                                            future: CommonOperation.getSharedData(
                                                index.toString() + AllConstant.IAMGE_BIG_TEXT, "Taylor Swift | The Eras Tour"),
                                            builder: (context, AsyncSnapshot<String> snapshot) {
                                              if (!snapshot.hasData) {
                                                return Container();
                                              } else {
                                                return GestureDetector(
                                                  onTap: () async {
                                                    String? result = await CustomInputDialog.showInputDialog(
                                                        context: context,
                                                        defaultTxt: "Taylor Swift | The Eras Tour",
                                                        key: index.toString() + AllConstant.IAMGE_BIG_TEXT,
                                                        textInputType: TextInputType.number);
                                                    if (result != null) {
                                                      PrefUtil.preferences!.setString(
                                                        index.toString() + AllConstant.IAMGE_BIG_TEXT,
                                                        result,
                                                      );
                                                      setState(() {});
                                                    } else {
                                                      print("Dialog was canceled");
                                                    }
                                                  },
                                                  child: Container(
                                                    child: Text(snapshot.data!,
                                                        maxLines: 1,
                                                        textAlign: TextAlign.start,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontSize: PrefUtil.preferences!
                                                                    .getDouble(index.toString() + AllConstant.IncreaseDecreaseFontMain) ??
                                                                18,
                                                            fontFamily: "metropolis",
                                                            fontWeight: CommonOperation.getFontWeight(),
                                                            color: AppColor.white)),
                                                  ),
                                                );
                                              }
                                            },
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    FutureBuilder<String>(
                                      future: CommonOperation.getSharedData(
                                          index.toString() + AllConstant.IAMGE_BIG_TEXT_2, "Taylor Swift | The Eras Tour"),
                                      builder: (context, AsyncSnapshot<String> snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container();
                                        } else {
                                          return GestureDetector(
                                            onTap: () async {
                                              String? result = await CustomInputDialog.showInputDialog(
                                                  context: context,
                                                  defaultTxt: "Taylor Swift | The Eras Tour",
                                                  key: index.toString() + AllConstant.IAMGE_BIG_TEXT_2,
                                                  textInputType: TextInputType.number);
                                              if (result != null) {
                                                PrefUtil.preferences!.setString(
                                                  index.toString() + AllConstant.IAMGE_BIG_TEXT_2,
                                                  result,
                                                );
                                                setState(() {});
                                              } else {
                                                print("Dialog was canceled");
                                              }
                                            },
                                            child: Container(
                                              child: Text(snapshot.data!,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize:
                                                          PrefUtil.preferences!.getDouble(index.toString() + AllConstant.IncreaseDecreaseFontMain) ??
                                                              18,
                                                      fontFamily: "metropolis",
                                                      fontWeight: CommonOperation.getFontWeight(),
                                                      color: AppColor.white)),
                                            ),
                                          );
                                        }
                                      },
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
                                            future: CommonOperation.getSharedData(
                                                index.toString() + AllConstant.DATE, "Sat, Dec 18, 4:30pm . SofFi Stadium"),
                                            builder: (context, AsyncSnapshot<String> snapshot) {
                                              if (!snapshot.hasData) {
                                                return Container();
                                              } else {
                                                return GestureDetector(
                                                  onTap: () async {
                                                    String? result = await CustomInputDialog.showInputDialog(
                                                        context: context,
                                                        defaultTxt: "Sat, Dec 18, 4:30pm . SofFi Stadium",
                                                        key: index.toString() + AllConstant.DATE,
                                                        textInputType: TextInputType.number);
                                                    if (result != null) {
                                                      PrefUtil.preferences!.setString(
                                                        index.toString() + AllConstant.DATE,
                                                        result,
                                                      );
                                                      setState(() {});
                                                    } else {
                                                      print("Dialog was canceled");
                                                    }
                                                  },
                                                  child: Text(snapshot.data!,
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: "metropolis",
                                                          fontWeight: FontWeight.normal,
                                                          color: AppColor.white)),
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
                                                onTap: () async {
                                                  String? result = await CustomInputDialog.showInputDialog(
                                                      context: context,
                                                      defaultTxt: "6",
                                                      key: index.toString() + AllConstant.SELECTED_TICKET_COUNT,
                                                      textInputType: TextInputType.number);
                                                  if (result != null) {
                                                    if (int.parse(result) < 2 || int.parse(result) > 10) return;

                                                    PrefUtil.preferences!.setString(index.toString() + AllConstant.SELECTED_TICKET_COUNT, result);
                                                    setState(() {});
                                                  } else {
                                                    print("Dialog was canceled");
                                                  }

                                                  setState(() {});
                                                },
                                                child: Text(snapshot.data! + " tickets",
                                                    style: TextStyle(
                                                        fontSize: 12, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
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
                                                onTap: () async {
                                                  String? result = await CustomInputDialog.showInputDialog(
                                                      context: context,
                                                      defaultTxt: "0",
                                                      key: index.toString() + AllConstant.SELECTED_LISTED,
                                                      textInputType: TextInputType.number);
                                                  if (result != null) {
                                                    PrefUtil.preferences!.setString(
                                                      index.toString() + AllConstant.SELECTED_LISTED,
                                                      result,
                                                    );
                                                    setState(() {});
                                                  } else {
                                                    print("Dialog was canceled");
                                                  }

                                                  setState(() {});
                                                },
                                                child: Text(snapshot.data! + " listed",
                                                    style: TextStyle(
                                                        fontSize: 12, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
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
}
