import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/utils/settings.dart';
import 'package:notes_app/widgets/custom_appbar.dart';
import 'package:notes_app/widgets/dialog/loadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:notes_app/widgets/navDrawer.dart';
import 'package:flutter/material.dart';
import '../styles.dart';
import '../widgets/dialog/updatePassword.dart';
import 'notes/newNote.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  bool shouldPop = false; //to make sure can't go back
  bool? signed = false;
  bool loaded = false;

  List<String> itemListTest = [
    "Item 1",
    "Item 2 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum lobortis tempus lectus. Phasellus scelerisque tortor elit, vel pellentesque augue maximus id. ",
    "Item 3 Proin nec lacus in nisi gravida lacinia. Nam rhoncus, dolor ac imperdiet cursus, purus dui auctor mi, sit amet placerat ex est tempor metus. Suspendisse in faucibus urna. In sollicitudin egestas eros vitae sodales. Sed sed placerat lorem, eu tincidunt nisl. Etiam dolor felis, posuere eget massa et, porttitor sodales quam. Mauris finibus tristique nisl sed volutpat. Donec nulla tellus, molestie vitae vulputate sit amet, faucibus sit amet sem. Aliquam",
    "Item 4 aliquam, bibendum quam nec, iaculis odio. Ut sed ullamcorper felis. Morbi tincidunt elit ac erat ornare sodales sit amet vestibulum ante. Ut sapien erat, dignissim",
    "Item 5 Sed condimentum "
  ];

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    signed = await Settings.getSigned();
    setState(() {
      loaded = true;
    });
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
            rightIcon: signed! ? "profile" : "",
            onPress: () {
              updatePasswordPopup(context, oldPassword, newPassword);
            },
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
            backgroundColor: defaultColor,
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop, child: NewNote()));
            }),
        body: loaded
            ? GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: width,
                    child: DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        appBar: const TabBar(
                          indicatorColor: defaultColor,
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
                            child: MasonryGridView.count(
                              crossAxisCount: 2,
                              itemCount: itemListTest.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.all(5),
                                  color: Colors.black26,
                                  padding: const EdgeInsets.all(10),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minHeight: 50.0,
                                      maxHeight: 150.0,
                                    ),
                                    child: Text(itemListTest[index]),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Center(
                            child: Text("data 2"),
                          ),
                        ]),
                      ),
                    )),
              )
            : loadingDialog(context),
      ),
    );
  }
}
