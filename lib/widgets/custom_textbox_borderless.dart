import 'package:flutter/services.dart';
import '../styles.dart';
import 'package:flutter/material.dart';

class CustomTextBoxBorderLess extends StatelessWidget {
  TextEditingController controller;
  TextCapitalization textCapitalization;
  TextInputType keyboardType;
  bool phoneNumber;
  bool readOnly;
  bool enabled;
  int minLine;
  int maxLine;
  String? labelText;
  String? errorText;
  Widget? prifixIcon;
  bool obscureText;

  CustomTextBoxBorderLess({
    required this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.phoneNumber = false,
    this.readOnly = false,
    this.enabled = true,
    this.minLine = 1,
    this.maxLine = 1,
    this.labelText,
    this.errorText,
    this.prifixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: EdgeInsets.only(left: prifixIcon != null ? 50 : 10, right: 10),
        child: TextFormField(
          style: const TextStyle(fontSize: 18.0, fontFamily: defaultFont),
          maxLines: maxLine,
          minLines: minLine,
          keyboardType: keyboardType,
          autofocus: false,
          textCapitalization: textCapitalization,
          controller: controller,
          obscureText: obscureText,
          readOnly: readOnly,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[50],
            labelText: labelText,
            labelStyle: LabelStyle1,
            errorText: errorText,
            errorStyle: errorStyle,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            enabled: enabled,
          ),
        ),
      ),
      Container(
        child: prifixIcon != null
            ? Container(
                width: 35,
                height: 35,
                margin: const EdgeInsets.only(left: 3, top: 7),
                child: prifixIcon,
              )
            : null,
      )
    ]);
  }
}
