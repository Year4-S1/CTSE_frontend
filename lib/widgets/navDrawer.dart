import 'package:flutter/material.dart';
import 'package:notes_app/api/api_calls.dart';
import 'package:notes_app/screens/catagories/catagoryMenu.dart';
import 'package:notes_app/screens/onBoarding/login.dart';
import 'package:notes_app/utils/settings.dart';
import 'package:notes_app/widgets/dialog/loadingDialog.dart';
import 'package:page_transition/page_transition.dart';

import '../styles.dart';

class NavDrawer extends StatefulWidget {
  NavDrawer();

  @override
  _NavDrawerScreen createState() => _NavDrawerScreen();
}

class _NavDrawerScreen extends State<NavDrawer> {
  Map<String, dynamic> catagoryList = {};
  bool shouldPop = true;
  bool loaded = false;
  String? userId;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    userId = await Settings.getUserID();
    var res = await ApiCalls.getCatagories(userId: userId!);

    catagoryList = res.jsonBody;

    setState(() {
      loaded = true;
    });
  }

  logout() async {
    await Settings.setAccessToken("");
    await Settings.setUserID("");

    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.bottomToTop, child: LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 80,
          ),
          const Center(child: Text("Noteworthy", style: SplashLogoText)),
          const SizedBox(
            height: 40,
          ),
          ListTile(
            leading: IconButton(
                icon: const Icon(
                  Icons.notes,
                  color: defaultColor,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: const Text(
              'All notes',
              style: SubHeadStyle,
            ),
            trailing: const Text(
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
            trailing: const Text(
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
          Container(
            height: height - 380,
            alignment: Alignment.center,
            child: catagoryList.isNotEmpty
                ? GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const ScrollPhysics(),
                    itemCount: catagoryList['data'].length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 50, crossAxisCount: 1),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: IconButton(
                            icon: Icon(
                              Icons.bookmark,
                              color: iconColorSetter(
                                  catagoryList['data'][index]['categoryColor']),
                              size: 30,
                            ),
                            onPressed: () {}),
                        title: Text(
                          catagoryList['data'][index]['categoryName']
                              .toString(),
                          overflow: TextOverflow.ellipsis,
                          style: SubHeadStyle,
                        ),
                        trailing: const Text(
                          "0",
                          style: SubHeadStyle,
                        ),
                        onTap: () => {},
                      );
                    },
                  )
                : loadingDialog(context),
          ),
          SizedBox(
            height: 50,
            child: ListTile(
              title: const Text(
                "Logout",
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: SubHeadStyle,
              ),
              trailing: IconButton(
                  icon: const Icon(
                    Icons.logout_sharp,
                    color: defaultColor,
                    size: 30,
                  ),
                  onPressed: () {}),
              onTap: () {
                logout();
              },
            ),
          )
        ],
      ),
    );
  }

  iconColorSetter(String color) {
    switch (color) {
      case "pink":
        return catagoryPink;
      case "purple":
        return catagoryPurple;
      case "blue":
        return catagoryBlue;
      case "green":
        return catagoryGreen;
      case "yellow":
        return catagoryYellow;
      case "orange":
        return catagoryOrange;
      default:
        return Colors.black26;
    }
  }
}
