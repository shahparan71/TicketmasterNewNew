import 'package:flutter/material.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

class CustomBuilderWidget extends StatefulWidget {
  final String keyValue;
  final String defaultValue;
  final TextStyle? textStyle; // Add TextStyle parameter

  const CustomBuilderWidget({
    Key? key,
    required this.keyValue,
    required this.defaultValue,
    this.textStyle, // Accept TextStyle parameter
  }) : super(key: key);

  @override
  _CustomBuilderWidgetState createState() => _CustomBuilderWidgetState();
}

class _CustomBuilderWidgetState extends State<CustomBuilderWidget> {
  Future<String> _getData() async {
    return await CommonOperation.getSharedData(widget.keyValue, widget.defaultValue);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getData(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          return GestureDetector(
            onTap: () async {
              String? result = await CustomInputDialog.showInputDialog(
                context: context,
                defaultTxt: widget.defaultValue,
                key: widget.keyValue,
              );
              if (result != null) {
                PrefUtil.preferences!.setString(
                  widget.keyValue,
                  result,
                );
                setState(() {}); // Refresh the widget after updating value
              } else {
                print("Dialog was canceled");
              }
            },
            child: Text(
              snapshot.data ?? "",
              style: widget.textStyle ?? TextStyle(), // Use the passed TextStyle
            ),
          );
        }
      },
    );
  }
}
