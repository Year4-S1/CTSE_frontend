import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../styles.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatefulWidget {
  String text;
  double width = 330.0;
  double height;
  IconData? icon;

  CustomTile(
      {required this.text, required this.width, this.height = 45.0, this.icon});

  @override
  _CustomTileScreen createState() => _CustomTileScreen();
}

class _CustomTileScreen extends State<CustomTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/white-button2.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Row(
          children: [
            Container(
                child: widget.icon != null
                    ? Container(
                        width: 60,
                        height: 40,
                        alignment: Alignment.center,
                        child: FaIcon(
                          widget.icon,
                          size: 25.0,
                          color: Colors.black26,
                        ),
                      )
                    : null),
            Padding(
              padding: EdgeInsets.only(left: widget.icon != null ? 0 : 60),
              child: Text(
                widget.text,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black54,
                    fontFamily: defaultFont,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }
}
