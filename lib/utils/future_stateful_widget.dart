import 'package:flutter/material.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

class CustomBuilderWidget extends StatefulWidget {
  final String keyValue;
  final String defaultValue;
  final TextStyle? style; // Add TextStyle parameter
  final int? maxLines; // Optional maxLines parameter
  final TextAlign? textAlign; // Optional textAlign parameter
  final TextOverflow? overflow; // Optional overflow parameter
  final TextInputType? textInputType; // Optional overflow parameter

  const CustomBuilderWidget({
    Key? key,
    required this.keyValue,
    required this.defaultValue,
    this.style, // Accept TextStyle parameter
    this.maxLines, // Optional maxLines
    this.textAlign, // Optional textAlign
    this.overflow, // Optional overflow
    this.textInputType, // Optional overflow
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
                  context: context, defaultTxt: widget.defaultValue, key: widget.keyValue, textInputType: widget.textInputType ?? TextInputType.text);
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
              style: widget.style ?? TextStyle(), // Use the passed TextStyle
              maxLines: widget.maxLines, // Use the passed maxLines or null
              textAlign: widget.textAlign, // Use the passed textAlign or null
              overflow: widget.overflow, // Use the passed overflow or null
            ),
          );
        }
      },
    );
  }
}
