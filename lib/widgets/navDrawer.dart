import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/screens/catagories/catagoryMenu.dart';
import 'package:page_transition/page_transition.dart';

import '../styles.dart';

class NavDrawer extends StatefulWidget {
  NavDrawer();

  @override
  _NavDrawerScreen createState() => _NavDrawerScreen();
}

class _NavDrawerScreen extends State<NavDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 80,
          ),
          Center(child: const Text("Noteworthy", style: SplashLogoText)),
          const SizedBox(
            height: 40,
          ),
          ListTile(
            leading: IconButton(
                icon: Icon(
                  Icons.notes,
                  color: defaultColor,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              'All notes',
              style: SubHeadStyle,
            ),
            trailing: Text(
              "2",
              style: SubHeadStyle,
            ),
            onTap: () => {},
          ),
          Container(
            height: 10,
            color: Colors.black12,
          ),
          ListTile(
            title: Text(
              'Catagories',
              style: greyNormalTextStyle,
            ),
            trailing: Text(
              "Edit",
              style: SeeAllStyle,
            ),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: CatagoryMenuScreen())),
            },
          ),
          ListTile(
            leading: IconButton(
                icon: Icon(
                  Icons.bookmark,
                  color: Colors.red,
                  size: 30,
                ),
                onPressed: () {}),
            title: Text(
              'Work',
              style: SubHeadStyle,
            ),
            trailing: Text(
              "0",
              style: SubHeadStyle,
            ),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
