import 'package:flutter/material.dart';
import 'package:notes_app/screens/home.dart';
import 'package:notes_app/screens/notes/newNote.dart';
import 'package:page_transition/page_transition.dart';
import '../styles.dart';

class CustomAppbarWidget extends StatefulWidget {
  String mainTitle = "Noteworthy";
  String leading;
  bool logo;
  bool save = false;
  Widget? navLocation;
  GlobalKey<ScaffoldState>? drawerKey = GlobalKey();

  CustomAppbarWidget(
      {required this.mainTitle,
      required this.leading,
      required this.logo,
      required this.save,
      this.navLocation,
      this.drawerKey});

  @override
  _CustomAppbarWidgetState createState() => new _CustomAppbarWidgetState();
}

class _CustomAppbarWidgetState extends State<CustomAppbarWidget> {
  @override
  initState() {
    widget.navLocation ??= HomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: leadingButton(
          widget.leading, context, widget.drawerKey, widget.navLocation!),
      actions: [
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 20),
            child: widget.save
                ? GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Save",
                      style: SeeAllStyle,
                    ),
                  )
                : null),
      ],
      title: widget.logo
          ? const Padding(
              padding: EdgeInsets.only(left: 50),
              child: Text("Noteworthy", style: LogoText),
            )
          : Text(
              widget.mainTitle,
              style: HeaderStyle,
            ),
    );
  }
}

leadingButton(String leading, BuildContext context,
    GlobalKey<ScaffoldState>? drawerKey, Widget? navLocation) {
  if (leading == "Back") {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black45),
        onPressed: () {
          Navigator.pop(context);
        });
  } else if (leading == "Navigate") {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black45),
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft, child: navLocation!));
        });
  } else if (leading == "Menu") {
    return IconButton(
        icon: const Icon(Icons.menu, color: Colors.black45),
        onPressed: () {
          drawerKey!.currentState?.openDrawer();
        });
  } else if (leading == "None") {
    return Container(
      width: 15,
    );
  } else {
    return Container(
      width: 15,
    );
  }
}
