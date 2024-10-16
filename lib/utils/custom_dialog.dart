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
          content: Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Using WidgetsUtil.inputBoxForAll with the locally created controller
                WidgetsUtil.inputBoxForAll(defaultTxt, key, textEditingController, inputType: textInputType),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "metropolis",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.green,
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
