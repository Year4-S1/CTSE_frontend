import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/widgets/custom_appbar.dart';
import 'package:notes_app/widgets/custom_tile.dart';
import 'package:notes_app/widgets/navDrawer.dart';
import 'package:page_transition/page_transition.dart';

import '../styles.dart';
import 'notes/newNote.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  bool shouldPop = false; //to make sure can't go back

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Scaffold(
        key: _drawerKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: CustomAppbarWidget(
            mainTitle: "Noteworthy",
            leading: "Menu",
            logo: true,
            save: false,
            navLocation: HomeScreen(),
            drawerKey: _drawerKey,
          ),
        ),
        drawer: NavDrawer(),
        floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            child: const Icon(
              Icons.note_alt_outlined,
              size: 35,
            ),
            backgroundColor: DefaultColor,
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop, child: NewNote()));
            }),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: width,
              child: const DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: TabBar(
                    indicatorColor: DefaultColor,
                    indicatorWeight: 1.0,
                    tabs: [
                      Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 10),
                        child: Text(
                          "Notes",
                          style: HeaderStyle2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 10),
                        child: Text(
                          "Todo",
                          style: HeaderStyle2,
                        ),
                      ),
                    ],
                  ),
                  body: TabBarView(children: [
                    Center(
                      child: Text("data 1"),
                    ),
                    Center(
                      child: Text("data 2"),
                    ),
                  ]),
                ),
              )),
        ),
      ),
    );
  }
}
