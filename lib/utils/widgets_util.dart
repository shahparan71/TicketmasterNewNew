import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/all_constant.dart';

class DiscoverImage extends StatefulWidget {
  @override
  State<DiscoverImage> createState() => _DiscoverImageState();
}

class _DiscoverImageState extends State<DiscoverImage> {
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
                          onTap: () {
                            pickImageDiscover();
                          },
                        ),
                      ],
                    )
                  : Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
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
                    onTap: () {
                      pickImage(1, AllConstant.DISCOVER_IMAGE_PATH, context);
                    },
                  ),
                  GestureDetector(
                      onTap: () {
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
  static ElevatedButton CustomElevatedButton({String? buttonText, Function? function}) {
    return ElevatedButton(
      child: Text("$buttonText", style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(AppColor.colorMain()),
          backgroundColor: MaterialStateProperty.all<Color>(AppColor.colorMain()),
          elevation: MaterialStateProperty.all(0.0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)), /*side: BorderSide(color: Colors.red)*/
          ))),
      onPressed: () {
        function!("$buttonText");
      },
    );
  }
}
