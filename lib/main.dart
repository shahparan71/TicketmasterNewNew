import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/all_uis/initial_screen.dart';
import 'package:ticket_master/all_uis/user_add_dialog.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PrefUtil.init();
  runApp(
    MaterialApp(
      title: 'Flutter Database Example',
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
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController = TextEditingController();

  int changeView = 0;
  List<User> listUser = [];

  bool dateLoading = false;

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
                Text(
                  changeView == 0 ? "Login" : "User List",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                  onTap: () {
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
                      : Container(),
                ),
              ],
            ),
            leadingWidth: 0.0,
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
                                        "No user found",
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
                                                        onTap: () {
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
                                                                                onTap: () {
                                                                                  Navigator.of(context).pop(true);
                                                                                },
                                                                              ),
                                                                              GestureDetector(
                                                                                onTap: () {
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
                                                              showSnackBar("User Remove Successfully");
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
                            onPressed: () {
                              addUser();
                            },
                            tooltip: 'Standard',
                            child: const Icon(Icons.add),
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
                      keyboardType: TextInputType.number,
                      controller: textEditingController,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'User ID', hintText: 'Enter ID'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  dateLoading == true
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          child: Text("Login", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(AppColor.colorMain()),
                              backgroundColor: MaterialStateProperty.all<Color>(AppColor.colorMain()),
                              elevation: MaterialStateProperty.all(0.0),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6)), /*side: BorderSide(color: Colors.red)*/
                              ))),
                          onPressed: () {
                            _login();
                          },
                        )
                ],
              ),
      ),
    );
  }

  Future<void> _login() async {
    if (textEditingController.text.isEmpty) {
      showSnackBar("User ID can't be empty");
      return;
    }

    if (textEditingController.text == "786") {
      PrefUtil.preferences!.setInt(AllConstant.USER_LOGIN_MODE, 1);
      textEditingController.text = "";
      setState(() {
        changeView = 1;
        initUserListDate();
      });
      return;
    }

    setState(() {
      dateLoading = true;
    });

    final DatabaseReference reference = FirebaseDatabase.instance.ref().child('Users').child("${textEditingController.text}");

    reference.once().then((DatabaseEvent event) {
      // Here I iterate and create the list of objects
      DataSnapshot snapshot = event.snapshot;

      print("event.snapshot.children.length");
      print(event.snapshot.children.length);

      if (event.snapshot.children.length == 0) {
        showSnackBar("User Not found");
        return;
      } else {
        setState(() {
          dateLoading = false;
          textEditingController.text = "";
        });
        PrefUtil.preferences!.setInt(AllConstant.USER_LOGIN_MODE, 2);
        Future.delayed(Duration.zero, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InitialScreen()),
          );
        });
      }
    });
  }

  Future<void> showSnackBar(String s) async {
    final SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      width: 400.0,
      content: Text(s),
      duration: const Duration(milliseconds: 1000),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    await Future.delayed(const Duration(milliseconds: 1500), () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
        showSnackBar("Name or ID field can't be empty");
      }

      final DatabaseReference reference = FirebaseDatabase.instance.ref().child('Users').child("${value.toString().split(",")[1]}");

      await reference.once().then((DatabaseEvent event) async {
        if (event.snapshot.children.length > 0) {
          showSnackBar("User already taken");
          return;
        } else {
          final DatabaseReference referenceAddUser = FirebaseDatabase.instance.ref().child('Users');
          await referenceAddUser.child("${value.toString().split(",")[1]}").set(<String, Object>{
            "name": "${value.toString().split(",")[0]}",
            "date": "${DateTime.now()}",
            "isEnable": true,
          }).then((onValue) {
            showSnackBar("User added successfully");
            dataInit();
          }).catchError((onError) {
            showSnackBar("User failed to add");
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
        Future.delayed(Duration.zero, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InitialScreen()),
          );
        });
      }
    }
  }

  Future<void> updateField(User listUser) async {
    final DatabaseReference referenceAddUser = FirebaseDatabase.instance.ref().child('Users');
    await referenceAddUser.child("${listUser.id}").update({"isEnable": listUser.isEnable}).then((onValue) {
      showSnackBar("Update successfully");
      dataInit();
    }).catchError((onError) {
      showSnackBar("User failed to add");
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

            listUser.add(new User(name: value['name'], date: value['date'], isEnable: value['isEnable'], id: key));
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

          listUser.add(new User(name: value['name'], date: value['date'], isEnable: value['isEnable'], id: int.parse(key)));
        });
      }

      setState(() {
        dateLoading = false;
      });
    });
  }
}

class User {
  String? name;
  int? id;
  String? date;
  bool? isEnable;

  User.name();

  User({this.name, this.id, this.date, this.isEnable});
}
