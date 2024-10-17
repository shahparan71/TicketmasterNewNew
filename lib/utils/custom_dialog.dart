import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/widgets_util.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

class CustomInputDialog {
  static Future<String?> showInputDialog({
    required BuildContext context,
    required String defaultTxt,
    required String key,
    TextInputType? textInputType,
  }) {
    // Create a local TextEditingController inside the method
    TextEditingController textEditingController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Container(
            height: 200,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Using WidgetsUtil.inputBoxForAll with the locally created controller
                WidgetsUtil.inputBoxForAll(defaultTxt, key, textEditingController, inputType: textInputType),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "OK",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "metropolis",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(1),
                    elevation: 0.0,
                    backgroundColor: AppColor.buttonColorMain(),
                    // Background color
                    foregroundColor: Colors.white,
                    // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                    ),
                  ),
                  onPressed: () {
                    if (textEditingController.text.isNotEmpty) {
                      Navigator.of(context).pop(textEditingController.text);
                    } else {
                      Navigator.of(context).pop(null);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
