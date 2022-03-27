import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/api/api_calls.dart';
import 'package:notes_app/screens/notes/updateNote.dart';
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
  String? userId;
  String? activeCategory;
  bool loaded = false;

  List noteList = [];

  @override
  void initState() {
    getNotes();
    super.initState();
  }

  getNotes() async {
    setState(() {
      loaded = false;
      noteList.clear();
    });

    signed = await Settings.getSigned();
    userId = await Settings.getUserID();
    activeCategory = await Settings.getActiveCategory();

    var res = await ApiCalls.getNotes(userId: userId!);

    Map<String, dynamic> response = res.jsonBody;

    for (int i = 0; i < response['data'].length; i++) {
      if (activeCategory == response['data'][i]['categoryColor']) {
        noteList.add(response['data'][i]);
      } else if (activeCategory == "all") {
        noteList.add(response['data'][i]);
      } else {
        noteList.add(response['data'][i]);
      }
    }

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
            rightOnPress: () {
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
                          noteList.isNotEmpty
                              ? RefreshIndicator(
                                  onRefresh: _pullRefresh,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: MasonryGridView.count(
                                        crossAxisCount: 2,
                                        itemCount: noteList.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .bottomToTop,
                                                      child: UpdateNote(
                                                        noteDetails:
                                                            noteList[index],
                                                      )));
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(5),
                                              color: noteColorSetter(
                                                  noteList[index]
                                                      ['categoryColor']),
                                              padding: const EdgeInsets.all(10),
                                              child: ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 50.0,
                                                  maxHeight: 150.0,
                                                ),
                                                child: Text(
                                                    noteList[index]
                                                        ['noteMessage'],
                                                    textAlign:
                                                        TextAlign.justify),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "No Notes",
                                    style: greyNormalTextStyle,
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

  noteColorSetter(String color) {
    switch (color) {
      case "pink":
        return notePink;
      case "purple":
        return notePurple;
      case "blue":
        return noteBlue;
      case "green":
        return noteGreen;
      case "yellow":
        return noteYellow;
      case "orange":
        return noteOrange;
      default:
        return noteUnassigned;
    }
  }

  Future<void> _pullRefresh() async {
    setState(() {
      getNotes();
    });
  }
}
