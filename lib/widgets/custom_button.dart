import '../styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  String text;
  double width = 330.0;
  double height;
  Function()? onTap;

  CustomButton({
    required this.text,
    required this.width,
    this.onTap,
    this.height = 45.0,
  });

  @override
  _CustomButtonScreen createState() => _CustomButtonScreen();
}

class _CustomButtonScreen extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Text(
              widget.text,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: defaultColor,
                  fontFamily: defaultFont,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          )),
    );
  }
}
