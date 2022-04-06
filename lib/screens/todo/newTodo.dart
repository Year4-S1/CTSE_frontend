import 'package:flutter/material.dart';
import 'package:noteworthy/api/api_calls.dart';
import 'package:noteworthy/screens/home.dart';
import 'package:noteworthy/utils/settings.dart';
import 'package:noteworthy/widgets/custom_appbar.dart';
import 'package:noteworthy/widgets/custom_datetime_picker.dart';
import 'package:noteworthy/widgets/custom_textbox_borderless.dart';
import 'package:noteworthy/widgets/dialog/loadingDialog.dart';
import 'package:page_transition/page_transition.dart';

import '../../styles.dart';
import '../../utils/helper.dart';
import '../../widgets/custom_textbox.dart';
import '../../widgets/dialog/saveDiscardPopup.dart';

class NewTodo extends StatefulWidget {
  _NewTodoState createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController reminderDate = TextEditingController();
  TextEditingController reminderTime = TextEditingController();

  Map<String, dynamic> _catagoryList = {};
  String _catagorySelected = "unassigned";
  DateTime reminderDateValue = DateTime.now();
  TimeOfDay reminderTimeValue = TimeOfDay.now();

  bool loaded = false;
  bool _valueSet = false;
  bool _reminderExpanded = false;
  bool _remarksExpanded = false;
  String? userId;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    userId = await Settings.getUserID();
    var res = await ApiCalls.getCatagories(userId: userId!);

    _catagoryList = res.jsonBody;

    setState(() {
      loaded = true;
    });
  }

  postTodo() async {
    setState(() {
      loaded = false;
    });

    if (titleController.text != "") {
      var res = await ApiCalls.postTodo(
        userId: userId!,
        catagoryColor:
            _catagorySelected == "" ? "unassigned" : _catagorySelected.trim(),
        todoTitle: titleController.text,
        todoRemakrs: _remarksExpanded ? remarksController.text : "",
        reminderDate: _reminderExpanded ? reminderDate.text : "",
        reminderTime: _reminderExpanded ? reminderTime.text : "",
      );

      var response = res.jsonBody;

      if (res.isSuccess) {
        snackBar("Saved", context);
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.bottomToTop,
              child: HomeScreen(
                tab: 1,
              )),
        );
      } else {
        snackBar("Something went wrong", context);
      }
    } else {
      snackBar("Enter title", context);
    }
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: CustomAppbarWidget(
          mainTitle: "Noteworthy",
          leading: "Back",
          logo: true,
          rightIcon: "save",
          backOnPress: () {
            saveDiscardPopup(context, "Todo", postTodo, discardNote);
          },
          rightOnPress: () {
            postTodo();
          },
          navLocation: HomeScreen(),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return !await saveDiscardPopup(
              context, "Todo", postTodo, discardNote);
        },
        child: loaded
            ? GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  height: height,
                  width: width,
                  padding: const EdgeInsets.only(top: 10),
                  alignment: Alignment.topCenter,
                  color: whiteColor,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            catagoryPicker(context),
                            Container(
                              width: width - 70,
                              margin: const EdgeInsets.only(
                                  right: 10, top: 10, bottom: 10, left: 15),
                              child: CustomTextBox(
                                controller: titleController,
                                labelText: "Title",
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 2,
                          width: width,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          color: Colors.black26,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _remarksExpanded
                                      ? _remarksExpanded = false
                                      : _remarksExpanded = true;

                                  if (!_remarksExpanded) {
                                    remarksController.clear();
                                  }
                                });
                              },
                              icon: Icon(
                                _remarksExpanded ? Icons.notes : Icons.notes,
                                color: _remarksExpanded
                                    ? errorColor
                                    : defaultColor,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: AnimatedContainer(
                                  duration: const Duration(seconds: 2),
                                  alignment: Alignment.center,
                                  clipBehavior: Clip.antiAlias,
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  height: 100,
                                  width: _remarksExpanded ? width - 70 : 0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black26, width: 2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Colors.white,
                                  ),
                                  child: _remarksExpanded
                                      ? CustomTextBoxBorderLess(
                                          controller: remarksController,
                                          labelText: "Remarks (Optional)",
                                          border: InputBorder.none,
                                          minLine: 4,
                                          maxLine: 6,
                                        )
                                      : Container()),
                            ),
                          ],
                        ),
                        Container(
                          height: 2,
                          width: width,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          color: Colors.black26,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _reminderExpanded
                                      ? _reminderExpanded = false
                                      : _reminderExpanded = true;

                                  if (!_reminderExpanded) {
                                    reminderDate.clear();
                                    reminderTime.clear();
                                  }
                                });
                              },
                              icon: Icon(
                                _reminderExpanded
                                    ? Icons.notifications_off
                                    : Icons.notifications,
                                color: _reminderExpanded
                                    ? errorColor
                                    : defaultColor,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: AnimatedContainer(
                                  duration: const Duration(seconds: 2),
                                  alignment: Alignment.center,
                                  clipBehavior: Clip.antiAlias,
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  height: 100,
                                  width: _reminderExpanded ? width - 70 : 0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black26, width: 2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Colors.white,
                                  ),
                                  child: _reminderExpanded
                                      ? CustomDateTimePicker(
                                          dateController: reminderDate,
                                          newDate: (value) {
                                            reminderDateValue = value;
                                          },
                                          timeController: reminderTime,
                                          newTime: (value) {
                                            reminderTimeValue = value;
                                          },
                                        )
                                      : Container()),
                            ),
                          ],
                        ),
                        Container(
                          height: 2,
                          width: width,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : loadingDialog(context),
      ),
    );
  }

  catagoryPicker(
    BuildContext context,
  ) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: 40,
      width: width - 350,
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Icon(
          Icons.bookmark,
          color:
              _valueSet ? iconColorSetter(_catagorySelected) : Colors.black38,
          size: 28,
        ),
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  height: height - 600,
                  alignment: Alignment.center,
                  child: _catagoryList.isNotEmpty
                      ? GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const ScrollPhysics(),
                          itemCount: _catagoryList['data'].length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 50, crossAxisCount: 1),
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: IconButton(
                                  icon: Icon(
                                    Icons.bookmark,
                                    color: iconColorSetter(_catagoryList['data']
                                        [index]['categoryColor']),
                                    size: 30,
                                  ),
                                  onPressed: () {}),
                              title: Text(
                                _catagoryList['data'][index]['categoryName']
                                            .toString() ==
                                        ""
                                    ? "Unassigned"
                                    : _catagoryList['data'][index]
                                            ['categoryName']
                                        .toString(),
                                overflow: TextOverflow.ellipsis,
                                style: SubHeadStyle,
                              ),
                              onTap: () {
                                setState(() {
                                  _valueSet = false;
                                  _catagorySelected = _catagoryList['data']
                                      [index]['categoryColor'];

                                  Navigator.pop(context);
                                  _valueSet = true;
                                });
                              },
                            );
                          },
                        )
                      : loadingDialog(context),
                ),
              );
            },
          );
        },
      ),
    );
  }

  discardNote() async {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.bottomToTop, child: HomeScreen()));
  }
}
