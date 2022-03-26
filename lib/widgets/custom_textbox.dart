import 'package:flutter/services.dart';
import '../styles.dart';
import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  TextEditingController controller;
  TextCapitalization textCapitalization;
  TextInputType keyboardType;
  bool readOnly;
  bool enabled;
  int minLine;
  int maxLine;
  TextStyle hintStyle;
  String? labelText;
  String? prifixIcon;
  String? type;
  bool obscureText;
  String? Function(dynamic)? validator;

  CustomTextBox({
    required this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.readOnly = false,
    this.enabled = true,
    this.type,
    this.minLine = 1,
    this.maxLine = 1,
    this.hintStyle = HintStyle1,
    this.labelText,
    this.prifixIcon,
    this.obscureText = false,
  });

  static InputBorder errorBorder =
      const OutlineInputBorder(borderSide: BorderSide(color: Colors.red));

  inputFormatter() {
    if (type == "phoneNumber") {
      return [
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        FilteringTextInputFormatter.deny(RegExp(r'^0+')),
        FilteringTextInputFormatter.deny(RegExp(r'^94+')),
        LengthLimitingTextInputFormatter(9),
      ];
    }
    if (type == "nic") {
      return [
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        FilteringTextInputFormatter.allow(RegExp('[x|X|v|V]')),
        LengthLimitingTextInputFormatter(12),
      ];
    }
    if (type == "number") {
      return [
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        // margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: TextFormField(
          style: greyNormalTextStyle,
          maxLines: maxLine,
          minLines: minLine,
          keyboardType: keyboardType,
          autofocus: false,
          inputFormatters: inputFormatter(),
          textCapitalization: textCapitalization,
          validator: validator,
          controller: controller,
          obscureText: obscureText,
          readOnly: readOnly,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintStyle: greyNormalTextStyle,
            labelText: labelText,
            labelStyle: greyNormalTextStyle,
            contentPadding: const EdgeInsets.fromLTRB(25.0, 10.0, 20.0, 5.0),
            // border: InputBorder.none,
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black26, width: 2.0)),
            errorBorder: errorBorder,
            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black26, width: 2.0)),
            focusedErrorBorder: errorBorder,
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black26, width: 2.0)),
            enabled: enabled,
          ),
        ),
      ),
    ]);
  }
}
