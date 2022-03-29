import 'package:flutter/material.dart';
import 'package:notes_app/api/api_calls.dart';
import 'package:notes_app/screens/home.dart';
import 'package:notes_app/utils/settings.dart';
import 'package:notes_app/widgets/custom_appbar.dart';
import 'package:notes_app/widgets/custom_textbox_borderless.dart';
import 'package:notes_app/widgets/dialog/loadingDialog.dart';
import 'package:page_transition/page_transition.dart';

import '../../styles.dart';
import '../../utils/helper.dart';
import '../../widgets/dialog/saveDiscardPopup.dart';

class NewNote extends StatefulWidget {
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  Map<String, dynamic> _catagoryList = {};
  String _catagorySelected = "unassigned";

  TextAlign textAlign = TextAlign.left;
  double fontSize = 18;
  String selectedIconIndex = "0";

  bool loaded = false;
  bool _valueSet = false;
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

  postNote() async {
    setState(() {
      loaded = false;
    });
    if (bodyController.text != "") {
      var res = await ApiCalls.postNote(
          userId: userId!,
          catagoryColor:
              _catagorySelected == "" ? "unassigned" : _catagorySelected.trim(),
          noteMessage: bodyController.text,
          noteTitle: titleController.text);

      var response = res.jsonBody;

      setState(() {
        loaded = true;
      });

      if (res.isSuccess) {
        snackBar("Saved", context);
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop, child: HomeScreen()));
      } else {
        snackBar("Something went wrong", context);
      }
    }
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
            saveDiscardPopup(context, "Note", postNote, discardNote);
          },
          rightOnPress: () {
            postNote();
          },
          navLocation: HomeScreen(),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return !await saveDiscardPopup(
              context, "Note", postNote, discardNote);
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: width - 50,
                              child: CustomTextBoxBorderLess(
                                controller: titleController,
                                labelText: "Title",
                              ),
                            ),
                            catagoryPicker(context),
                          ],
                        ),
                        Container(
                          width: width,
                          height: 2,
                          color: Colors.black38,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        Container(
                          width: width,
                          height: height - 270,
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextField(
                            minLines: 32,
                            maxLines: 36,
                            autocorrect: true,
                            controller: bodyController,
                            textAlign: textAlign,
                            style: TextStyle(
                                fontSize: fontSize, fontFamily: defaultFont),
                          ),
                        ),
                        SizedBox(
                          width: width,
                          height: 50,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    textAlign = TextAlign.left;
                                    selectedIconIndex = "0";
                                  });
                                },
                                icon: Icon(
                                  Icons.format_align_left,
                                  color: selectedIconIndex == "0"
                                      ? Colors.black87
                                      : Colors.black38,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    textAlign = TextAlign.center;
                                    selectedIconIndex = "1";
                                  });
                                },
                                icon: Icon(
                                  Icons.format_align_center,
                                  color: selectedIconIndex == "1"
                                      ? Colors.black87
                                      : Colors.black38,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    textAlign = TextAlign.justify;
                                    selectedIconIndex = "2";
                                  });
                                },
                                icon: Icon(
                                  Icons.format_align_justify,
                                  color: selectedIconIndex == "2"
                                      ? Colors.black87
                                      : Colors.black38,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    textAlign = TextAlign.right;
                                    selectedIconIndex = "3";
                                  });
                                },
                                icon: Icon(
                                  Icons.format_align_right,
                                  color: selectedIconIndex == "3"
                                      ? Colors.black87
                                      : Colors.black38,
                                ),
                              ),
                              Slider(
                                value: fontSize,
                                min: 14,
                                max: 26,
                                divisions: 6,
                                label: fontSize.round().toString(),
                                onChanged: (double value) {
                                  setState(() {
                                    fontSize = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        )
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
