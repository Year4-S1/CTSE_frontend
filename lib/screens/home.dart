import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:noteworthy/screens/todo/updateTodo.dart';
import 'package:noteworthy/widgets/dialog/loadingDialog.dart';
import 'package:noteworthy/screens/notes/updateNote.dart';
import 'package:noteworthy/widgets/custom_appbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:noteworthy/screens/todo/newTodo.dart';
import 'package:noteworthy/widgets/custom_tile.dart';
import 'package:noteworthy/widgets/navDrawer.dart';
import 'package:noteworthy/utils/settings.dart';
import '../widgets/dialog/updatePassword.dart';
import 'package:noteworthy/api/api_calls.dart';
import 'package:flutter/material.dart';
import '../utils/helper.dart';
import 'notes/newNote.dart';
import '../styles.dart';

class HomeScreen extends StatefulWidget {
  int? tab = 0;

  HomeScreen({this.tab});

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  List noteList = [];
  List todoList = [];

  bool shouldPop = false; //to make sure can't go back
  bool? signed = false; //check if user is signed in
  bool _loaded = false; //to check if data is loaded to load body

  String activeCategory = "all"; //used to filter notes
  String? userId;

  int tabSetter = 0; //tab state checker

  @override
  void initState() {
    getNotes();
    getTodos();

    if (widget.tab != null) {
      tabSetter = widget.tab!;
    }
    super.initState();
  }

  getNotes() async {
    setState(() {
      _loaded = false;
      noteList.clear();
    });

    signed = await Settings.getSigned();
    userId = await Settings.getUserID();
    activeCategory = (await Settings.getActiveCategory())!;

    var res = await ApiCalls.getNotes(userId: userId!);

    Map<String, dynamic> response = res.jsonBody;

    for (int i = 0; i < response['data'].length; i++) {
      if (activeCategory == response['data'][i]['categoryColor']) {
        noteList.add(response['data'][i]);
      } else if (activeCategory == "all") {
        noteList.add(response['data'][i]);
      } else {
        null;
      }
    }

    setState(() {
      _loaded = true;
    });
  }

  getTodos() async {
    setState(() {
      _loaded = false;
      todoList.clear();
    });

    signed = await Settings.getSigned();
    userId = await Settings.getUserID();
    activeCategory = (await Settings.getActiveCategory())!;

    var res = await ApiCalls.getTodos(userId: userId!);

    Map<String, dynamic> response = res.jsonBody;

    for (int i = 0; i < response['data'].length; i++) {
      if (activeCategory == response['data'][i]['categoryColor']) {
        todoList.add(response['data'][i]);
      } else if (activeCategory == "all") {
        todoList.add(response['data'][i]);
      } else {
        todoList.add(response['data'][i]);
      }
    }

    setState(() {
      _loaded = true;
    });
  }

  deleteTodo(String todoId) async {
    setState(() {
      _loaded = false;
    });

    var res = await ApiCalls.deleteTodo(
      todoId: todoId,
    );

    if (res.isSuccess) {
      getTodos();
      snackBar("Reminder Deleted", context);
    } else {
      snackBar("Something went wrong", context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: tabSetter == 0
                ? const Icon(
                    Icons.note_alt_outlined,
                    size: 35,
                  )
                : const Icon(
                    Icons.today,
                    size: 35,
                  ),
            backgroundColor: defaultColor,
            onPressed: () {
              tabSetter == 0
                  ? Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: NewNote()))
                  : Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: NewTodo()));
            }),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: width,
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: TabBar(
                    indicatorColor: defaultColor,
                    indicatorWeight: 1.0,
                    onTap: (index) {
                      setState(() {
                        tabSetter = index;
                      });
                    },
                    tabs: const [
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
                  body: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        notesBuilder(),
                        todoBuilder(),
                      ]),
                ),
              )),
        ),
      ),
    );
  }

  notesBuilder() {
    return Container(
      child: _loaded
          ? RefreshIndicator(
              onRefresh: _pullRefresh,
              child: noteList.isNotEmpty
                  ? Padding(
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
                                        type: PageTransitionType.bottomToTop,
                                        child: UpdateNote(
                                          noteDetails: noteList[index],
                                        )));
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                color: noteColorSetter(
                                    noteList[index]['categoryColor']),
                                padding: const EdgeInsets.all(10),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minHeight: 50.0,
                                    maxHeight: 140.0,
                                  ),
                                  child: Text(noteList[index]['noteMessage'],
                                      textAlign: TextAlign.left),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child: Center(
                            child: Text(
                              "No Notes",
                              style: greyNormalTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
            )
          : loadingDialog(context),
    );
  }

  todoBuilder() {
    return Container(
      child: _loaded
          ? RefreshIndicator(
              onRefresh: _pullRefresh,
              child: todoList.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                          child: MasonryGridView.count(
                        crossAxisCount: 1,
                        itemCount: todoList.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(todoList[index].toString()),
                            background: Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black12, width: 1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: const Color.fromARGB(148, 255, 17, 0),
                              ),
                              child: const Text(
                                "Delete Reminder",
                                style: DeleteStyle,
                              ),
                            ),
                            onDismissed: (direction) {
                              deleteTodo(todoList[index]['_id']);
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: UpdateTodo(
                                          todoDetails: todoList[index],
                                        )));
                              },
                              child: CustomTile(
                                todoId: todoList[index]['_id'],
                                text: todoList[index]['reminderTitle'],
                                category: todoList[index]['categoryColor'],
                              ),
                            ),
                          );
                        },
                      )),
                    )
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Center(
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
                    ),
            )
          : loadingDialog(context),
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {
      tabSetter == 0 ? getNotes() : getTodos();
    });
  }
}
