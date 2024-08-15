import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserAddDialogBody extends StatefulWidget {
  @override
  State<UserAddDialogBody> createState() => _UserAddDialogBodyState();
}

class _UserAddDialogBodyState extends State<UserAddDialogBody> {
  var textEditingControllerName = TextEditingController();
  var textEditingControllerID = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: textEditingControllerName,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'User Name', hintText: 'Name'),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: textEditingControllerID,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'User ID', hintText: 'Enter ID'),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(textEditingControllerName.text + "," + textEditingControllerID.text);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
