import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/utils/helper.dart';

import '../api/api_calls.dart';
import '../styles.dart';
import 'package:flutter/material.dart';

import '../utils/settings.dart';

class CustomTile extends StatefulWidget {
  String text;
  String category;
  String todoId;

  double height;

  CustomTile(
      {required this.text,
      required this.category,
      required this.todoId,
      this.height = 45.0});

  @override
  _CustomTileScreen createState() => _CustomTileScreen();
}

class _CustomTileScreen extends State<CustomTile> {
  bool checked = false;
  String? userId;

  setStatus() async {
    userId = await Settings.getUserID();

    var res = await ApiCalls.todoActiveSetter(
        active: checked, userId: userId!, todoId: widget.todoId);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      width: width,
      height: widget.height,
      decoration: BoxDecoration(
        border: checked
            ? Border.all(color: Colors.black12, width: 1)
            : Border.all(color: Colors.black26, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color:
            checked ? const Color.fromARGB(101, 233, 233, 233) : Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 40,
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                setState(() {
                  checked ? checked = false : checked = true;
                  setStatus();
                });
              },
              icon: checked
                  ? const FaIcon(
                      Icons.check_circle_rounded,
                      size: 25.0,
                      color: Colors.black26,
                    )
                  : FaIcon(
                      Icons.circle_outlined,
                      size: 25.0,
                      color: iconColorSetter(widget.category),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              widget.text,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black54,
                  fontFamily: defaultFont,
                  fontSize: 19,
                  fontWeight: checked ? FontWeight.w400 : FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
