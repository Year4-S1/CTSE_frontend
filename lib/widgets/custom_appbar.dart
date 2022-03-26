import 'package:flutter/material.dart';
import 'package:notes_app/screens/home.dart';
import 'package:page_transition/page_transition.dart';
import '../styles.dart';

class CustomAppbarWidget extends StatefulWidget {
  String mainTitle = "Noteworthy";
  String leading; // leading icon
  String rightIcon = "save"; //save || profile || ""
  bool logo; //middle logo
  Widget? navLocation; // back button nav
  void Function()? rightOnPress; // right action onpress
  void Function()? backOnPress; // left action onpress
  GlobalKey<ScaffoldState>? drawerKey = GlobalKey();

  CustomAppbarWidget(
      {required this.mainTitle,
      required this.leading,
      required this.logo,
      required this.rightIcon,
      this.rightOnPress,
      this.backOnPress,
      this.navLocation,
      this.drawerKey});

  @override
  _CustomAppbarWidgetState createState() => _CustomAppbarWidgetState();
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
      leading: leadingButton(widget.leading, context, widget.drawerKey,
          widget.navLocation!, widget.rightIcon, widget.backOnPress),
      actions: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 20),
          child: rightAction(widget.rightIcon, widget.rightOnPress),
        ),
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

rightAction(String type, void Function()? onPress) {
  if (type == "save") {
    return GestureDetector(
      onTap: onPress,
      child: const Text(
        "Save",
        style: SeeAllStyle,
      ),
    );
  } else if (type == "profile") {
    return GestureDetector(
      onTap: onPress,
      child: const Icon(
        Icons.person_sharp,
        color: Colors.black45,
      ),
    );
  } else {
    return null;
  }
}

leadingButton(
    String leading,
    BuildContext context,
    GlobalKey<ScaffoldState>? drawerKey,
    Widget? navLocation,
    String rightIcon,
    Function()? backOnPress) {
  if (leading == "Back") {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black45),
        onPressed: rightIcon == "save"
            ? backOnPress
            : () {
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
