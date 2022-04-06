import 'package:flutter/material.dart';
import 'package:noteworthy/api/api_calls.dart';
import 'package:noteworthy/screens/catagories/catagoryMenu.dart';
import 'package:noteworthy/screens/home.dart';
import 'package:noteworthy/screens/onBoarding/login.dart';
import 'package:noteworthy/utils/settings.dart';
import 'package:noteworthy/widgets/dialog/loadingDialog.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/favourite/favDash.dart';
import '../styles.dart';
import '../utils/helper.dart';

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
  double allNoteCount = 0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    userId = await Settings.getUserID();
    var res = await ApiCalls.getCatagories(userId: userId!);

    catagoryList = res.jsonBody;

    for (int i = 0; i < catagoryList['data'].length; i++) {
      allNoteCount = allNoteCount + catagoryList['data'][i]['noteCount'];
    }

    setState(() {
      loaded = true;
    });
  }

  activeCatagorySetter(String catageory) async {
    await Settings.setActiveCategory(catageory);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  logout() async {
    await Settings.setAccessToken("");
    await Settings.setUserID("");
    await Settings.setSigned(false);

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
            trailing: Text(
              allNoteCount.toInt().toString(),
              style: SubHeadStyle,
            ),
            onTap: () => {activeCatagorySetter("all")},
          ),
          ListTile(
            leading: IconButton(
                icon: const Icon(
                  Icons.star,
                  color: catagoryYellow,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: FavDash()));
                }),
            title: const Text(
              'Favourite',
              style: SubHeadStyle,
            ),
            onTap: () => {
              //
              activeCatagorySetter("favourite")
            },
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
          loaded
              ? Container(
                  height: height - 450,
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
                                    color: iconColorSetter(catagoryList['data']
                                        [index]['categoryColor']),
                                    size: 30,
                                  ),
                                  onPressed: () {}),
                              title: Text(
                                catagoryList['data'][index]['categoryName']
                                            .toString() ==
                                        ""
                                    ? "Unassigned"
                                    : catagoryList['data'][index]
                                            ['categoryName']
                                        .toString(),
                                overflow: TextOverflow.ellipsis,
                                style: SubHeadStyle,
                              ),
                              trailing: Text(
                                catagoryList['data'][index]['noteCount']
                                    .toString(),
                                style: SubHeadStyle,
                              ),
                              onTap: () {
                                activeCatagorySetter(catagoryList['data'][index]
                                    ['categoryColor']);
                              },
                            );
                          },
                        )
                      : Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: Center(
                              child: Text(
                                "No Todo",
                                style: greyNormalTextStyle,
                              ),
                            ),
                          ),
                        ),
                )
              : SizedBox(
                  height: height - 450,
                  child: loadingDialog(context),
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
}
