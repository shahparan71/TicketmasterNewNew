import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/all_uis/initial_screen.dart';
import 'package:ticket_master/all_uis/user_add_dialog.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/widgets_util.dart';
import 'package:unique_identifier/unique_identifier.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PrefUtil.init();
  runApp(
    MaterialApp(
      title: 'Ticketmaster',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isLive = true;

  @override
  void initState() {
    initScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Future<void> initScreen() async {
    await Future.delayed(const Duration(seconds: 1), () {
      if (isLive)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      else
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OfflineView()),
        );
    });
  }
}

class OfflineView extends StatefulWidget {
  @override
  State<OfflineView> createState() => _OfflineViewState();
}

class _OfflineViewState extends State<OfflineView> {
  TextEditingController textEditingControllerID = TextEditingController();

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: textEditingControllerID,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Enter PIN", hintText: 'Enter PIN'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: Text("Login", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(AppColor.colorMain()),
                  backgroundColor: MaterialStateProperty.all<Color>(AppColor.colorMain()),
                  elevation: MaterialStateProperty.all(0.0),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)), /*side: BorderSide(color: Colors.red)*/
                  ))),
              onPressed: () async {
                if (textEditingControllerID.text == "347612") {
                  PrefUtil.preferences!.setBool(AllConstant.OFFLINE_LOGIN, true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InitialScreen()),
                  );
                } else
                  WidgetsUtil.showSnackBar(context, "ID Not Valid", color: Colors.red);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> checkLogin() async {
    bool? blnLogin = await PrefUtil.preferences!.getBool(
      AllConstant.OFFLINE_LOGIN,
    );
    if (blnLogin == null) return;
    if (blnLogin) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InitialScreen()),
      );
    }
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingControllerID = TextEditingController();
  TextEditingController textEditingControllerPass = TextEditingController();

  int changeView = 0;
  List<User> listUser = [];
  bool dateLoading = false;
  bool isAdmin = false;

  @override
  void initState() {
    dataInit();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    textEditingControllerID.text = "anisxtmz";
                    textEditingControllerPass.text = "347612";
                    setState(() {});
                  },
                  child: Text(
                    changeView == 0 ? "Login" : "User List",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      changeView = 0;
                      PrefUtil.preferences!.setInt(AllConstant.USER_LOGIN_MODE, 0);
                    });
                  },
                  child: changeView == 1
                      ? Icon(
                          Icons.logout,
                          color: Colors.white,
                        )
                      : Container(
                          child: Switch(
                              value: isAdmin,
                              onChanged: (v) {
                                setState(() {
                                  isAdmin = !isAdmin;
                                });
                              }),
                        ),
                ),
              ],
            ),
            leading: Container(),
            backgroundColor: AppColor.colorMain()),
        body: changeView == 1
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: dateLoading == true
                            ? Container(
                                child: Center(child: CircularProgressIndicator()),
                              )
                            : listUser.length == 0
                                ? Container(
                                    child: Center(
                                      child: Text(
                                        "No user found add user",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: listUser.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0XFFffffff),
                                            boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                                            border: Border.all(color: Colors.black26),
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "ID: ${listUser[index].id}",
                                                      style: TextStyle(fontSize: 20),
                                                    ),
                                                    Switch(
                                                        value: listUser[index].isEnable!,
                                                        onChanged: (v) {
                                                          setState(() {
                                                            listUser[index].isEnable = !listUser[index].isEnable!;
                                                            updateField(listUser[index]);
                                                          });
                                                        })
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Name: ${listUser[index].name}",
                                                  style: TextStyle(fontSize: 20),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Date: ${DateFormat("yyyy-MM-dd HH:mm:ss a").format(DateTime.parse(listUser[index].date!))}",
                                                      style: TextStyle(fontSize: 20),
                                                    ),
                                                    GestureDetector(
                                                        onTap: () async {
                                                          showDialog(
                                                              context: context,
                                                              builder: (_) {
                                                                return AlertDialog(
//actions: [Text("Yes"), Text("No")],
                                                                  content: Container(
                                                                    height: 140,
                                                                    child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                      children: [
                                                                        Text(
                                                                          "Are you sure?\n Do you want to remove the user",
                                                                          textAlign: TextAlign.center,
                                                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 30),
                                                                          child: Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              GestureDetector(
                                                                                child: Text(
                                                                                  "Yes",
                                                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                                                                ),
                                                                                onTap: () async {
                                                                                  Navigator.of(context).pop(true);
                                                                                },
                                                                              ),
                                                                              GestureDetector(
                                                                                onTap: () async {
                                                                                  Navigator.of(context).pop(false);
                                                                                },
                                                                                child: Text(
                                                                                  "No",
                                                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
//myPledge: model,
                                                                  ),
                                                                );
                                                              }).then((value) {
                                                            print("ffsf${value}");
                                                            if (value != null && value == true) {
                                                              FirebaseDatabase.instance.ref().child("Users").child('${listUser[index].id}').remove();
                                                              WidgetsUtil.showSnackBar(context, "User Remove Successfully");
                                                              initUserListDate();
                                                            }
                                                          });
                                                        },
                                                        child: Icon(Icons.delete))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            backgroundColor: Colors.blueAccent,
                            onPressed: () {
                              addUser();
                            },
                            tooltip: 'Standard',
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
//padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      keyboardType: isAdmin ? TextInputType.text : TextInputType.number,
                      controller: textEditingControllerID,
                      decoration:
                          InputDecoration(border: OutlineInputBorder(), labelText: isAdmin ? 'Admin User ID' : "User ID", hintText: 'Enter ID'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  isAdmin
                      ? Padding(
//padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: textEditingControllerPass,
                            obscureText: true,
                            decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Admin Password", hintText: 'Enter Password'),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  dateLoading == true
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          child: Text("Login",
                              style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(AppColor.colorMain()),
                              backgroundColor: MaterialStateProperty.all<Color>(AppColor.colorMain()),
                              elevation: MaterialStateProperty.all(0.0),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6)), /*side: BorderSide(color: Colors.red)*/
                              ))),
                          onPressed: () async {
                            _login();
                          },
                        )
                ],
              ),
      ),
    );
  }

  Future<void> _login() async {
    if (textEditingControllerID.text.isEmpty) {
      WidgetsUtil.showSnackBar(context, "User ID can't be empty");
      return;
    }

    setState(() {
      dateLoading = true;
    });

    if (isAdmin) {
      if (textEditingControllerPass.text.isEmpty) {
        WidgetsUtil.showSnackBar(context, "Password can't be empty");
        setState(() {
          dateLoading = false;
        });
        return;
      }

      final DatabaseReference reference = FirebaseDatabase.instance.ref().child('Admins').child("1");

      reference.once().then((DatabaseEvent event) {
        setState(() {
          dateLoading = false;
        });

        if (event.snapshot.children.length == 0) {
          WidgetsUtil.showSnackBar(context, "User Not found");
          setState(() {
            dateLoading = false;
            textEditingControllerID.text = "";
            textEditingControllerPass.text = "";
          });
          return;
        } else {
          DataSnapshot snapshot = event.snapshot;
          if (snapshot.value is List) {
            List<dynamic> yearList = snapshot.value as List<dynamic>;

            Map<int, dynamic> yearMap = yearList.asMap();
            if (yearMap['UserID'] == textEditingControllerID.text && yearMap['Password'].toString() == textEditingControllerPass.text) {
              PrefUtil.preferences!.setInt(AllConstant.USER_LOGIN_MODE, 1);
              uiRefresh();
            } else {
              WidgetsUtil.showSnackBar(context, "ID or Password doesn't match");
            }
          } else if (snapshot.value is Map) {
            Map<dynamic, dynamic> yearMap = snapshot.value as Map<dynamic, dynamic>;

            if (yearMap['UserID'] == textEditingControllerID.text && yearMap['Password'].toString() == textEditingControllerPass.text) {
              PrefUtil.preferences!.setInt(AllConstant.USER_LOGIN_MODE, 1);
              WidgetsUtil.showSnackBar(context, "Login Successfully");
              uiRefresh();
            } else {
              WidgetsUtil.showSnackBar(context, "ID or Password doesn't match");
              setState(() {
                dateLoading = false;
              });
            }
          }
        }
      });

      return;
    }

    final DatabaseReference reference = FirebaseDatabase.instance.ref().child('Users').child("${textEditingControllerID.text}");

    reference.once().then((DatabaseEvent event) async {
      setState(() {
        dateLoading = false;
      });
      if (event.snapshot.children.length == 0) {
        WidgetsUtil.showSnackBar(context, "User Not found");
        setState(() {
          dateLoading = false;
          textEditingControllerID.text = "";
        });
        return;
      } else {
        DataSnapshot snapshot = event.snapshot;
        if (snapshot.value is List) {
          List<dynamic> yearList = snapshot.value as List<dynamic>;

          Map<int, dynamic> yearMap = yearList.asMap();
          if (yearMap['isEnable'] == false) {
            setState(() {
              dateLoading = false;
            });
            WidgetsUtil.showSnackBar(context, "You are not allowed to login");
            return;
          }
        } else if (snapshot.value is Map) {
          Map<dynamic, dynamic> yearMap = snapshot.value as Map<dynamic, dynamic>;

          var identifier = await UniqueIdentifier.serial;

          if (yearMap['isEnable'] == false) {
            WidgetsUtil.showSnackBar(context, "You are not allowed to login");
            return;
          }
          if (yearMap.containsKey('identifier')) {
            if (yearMap['identifier'] != identifier) {
              WidgetsUtil.showSnackBar(context, "You are logged in with another device");
              setState(() {
                dateLoading = false;
                textEditingControllerID.text = "";
              });
              return;
            }
          } else {
            yearMap['identifier'] = identifier;
            final DatabaseReference referenceAddUser = FirebaseDatabase.instance.ref().child('Users');
            await referenceAddUser.child("${textEditingControllerID.text}").update({"identifier": identifier}).then((onValue) {
              WidgetsUtil.showSnackBar(context, "Login Successfully");
//dataInit();
            }).catchError((onError) {
              WidgetsUtil.showSnackBar(context, "User failed to add");
            });
          }
        }

        PrefUtil.preferences!.setString(AllConstant.LOGIN_USER_ID, textEditingControllerID.text);
        PrefUtil.preferences!.setInt(AllConstant.USER_LOGIN_MODE, 2);

        setState(() {
          dateLoading = false;
          textEditingControllerID.text = "";
        });

        Future.delayed(Duration.zero, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InitialScreen()),
          );
        });
      }
    });
  }

  Future<void> addUser() async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: UserAddDialogBody(),
      ),
    ).then((value) async {
      if (value.toString().split(",")[0].isEmpty || value.toString().split(",")[1].isEmpty) {
        WidgetsUtil.showSnackBar(context, "Name or ID field can't be empty");
      }

      setState(() {
        dateLoading = true;
      });

      final DatabaseReference reference = FirebaseDatabase.instance.ref().child('Users').child("${value.toString().split(",")[1]}");

      await reference.once().then((DatabaseEvent event) async {
        if (event.snapshot.children.length > 0) {
          WidgetsUtil.showSnackBar(context, "User already taken");
          return;
        } else {
          final DatabaseReference referenceAddUser = FirebaseDatabase.instance.ref().child('Users');
          await referenceAddUser.child("${value.toString().split(",")[1]}").set(<String, Object>{
            "name": "${value.toString().split(",")[0]}",
            "date": "${DateTime.now()}",
            "isEnable": true,
          }).then((onValue) {
            WidgetsUtil.showSnackBar(context, "User added successfully");
            setState(() {
              dateLoading = false;
            });
            dataInit();
          }).catchError((onError) {
            WidgetsUtil.showSnackBar(context, "User failed to add");
          });
        }
      });
    });
  }

  void dataInit() {
    var usrMode = PrefUtil.preferences!.getInt(AllConstant.USER_LOGIN_MODE);

    if (usrMode != null) {
      if (usrMode == 1) {
        setState(() {
          changeView = 1;
          initUserListDate();
        });
      }
      if (usrMode == 2) {
        var userID = PrefUtil.preferences!.getString(AllConstant.LOGIN_USER_ID);
        final DatabaseReference reference = FirebaseDatabase.instance.ref().child('Users').child("${userID}");

        reference.once().then((DatabaseEvent event) async {
          if (event.snapshot.children.length == 0) {
            WidgetsUtil.showSnackBar(context, "User not found, Please contact with admin");
            return;
          }

          Future.delayed(Duration.zero, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InitialScreen()),
            );
          });
        });
      }
    }
  }

  Future<void> updateField(User listUser) async {
    final DatabaseReference referenceAddUser = FirebaseDatabase.instance.ref().child('Users');
    await referenceAddUser.child("${listUser.id}").update({"isEnable": listUser.isEnable}).then((onValue) {
      WidgetsUtil.showSnackBar(context, "Update successfully");
//dataInit();
    }).catchError((onError) {
      WidgetsUtil.showSnackBar(context, "User failed to add");
    });
  }

  void initUserListDate() {
    setState(() {
      dateLoading = true;
    });
    final DatabaseReference reference = FirebaseDatabase.instance.ref().child('Users');
    reference.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      listUser.clear();

      if (snapshot.value is List) {
        List<dynamic> yearList = snapshot.value as List<dynamic>;
// Convert List to Map if necessary or handle it as a List
// Example: converting to Map with index as key
        Map<int, dynamic> yearMap = yearList.asMap();
        yearMap.forEach((key, value) {
          try {
            print(key);
            print(value['name']);
            print(value['id']);
            print(value['date']);
            print("value['isEnable']");

            listUser.add(new User(name: value['name'], date: value['date'], isEnable: value['isEnable'], id: key.toString()));
          } catch (e) {}
        });
      } else if (snapshot.value is Map) {
        Map<dynamic, dynamic> yearMap = snapshot.value as Map<dynamic, dynamic>;
        yearMap.forEach((key, value) {
          print(key);
          print(value['name']);
          print(value['id']);
          print(value['date']);
          print("value['isEnable']");

          listUser.add(new User(name: value['name'], date: value['date'], isEnable: value['isEnable'], id: key));
        });
      }

      setState(() {
        dateLoading = false;
      });
    });
  }

  void uiRefresh() {
    setState(() {
      changeView = 1;
      dateLoading = false;
      textEditingControllerID.text = "";
      textEditingControllerPass.text = "";
      initUserListDate();
    });
  }
}

class User {
  String? name;
  String? id;
  String? date;
  bool? isEnable;

  User.name();

  User({this.name, this.id, this.date, this.isEnable});
}

//flutter build appbundle --release
//fvm flutter build apk --release
