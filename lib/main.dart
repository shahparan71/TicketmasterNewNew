import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/all_uis/initial_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PrefUtil.init();
  runApp(
    const MaterialApp(
      title: 'Flutter Database Example',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Database Example'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _increment() async {
    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InitialScreen()),
    );
*/
    final DatabaseReference reference = FirebaseDatabase.instance.ref().child('Users').child("1");

    reference.once().then((DatabaseEvent event) {
      // Here I iterate and create the list of objects
      DataSnapshot snapshot = event.snapshot;

      print("event.snapshot.children.length");
      print(event.snapshot.children.length);

      if (event.snapshot.children.length == 0) return;

      Map<dynamic, dynamic> yearMap = snapshot.value as Map<dynamic, dynamic>;
      yearMap.forEach((key, value) {
        print(key);
        print(value['fullName']);
      });
    });

    /*await reference.child(reference.push().key!).set(<String, Object>{
      "mobileNumber": "userModel.mobileNumber",
      "userName": "userModel.userName",
      "fullName": "userModel.fullName",
    }).then((onValue) {
      return true;
    }).catchError((onError) {
      return false;
    });*/
  }
}
