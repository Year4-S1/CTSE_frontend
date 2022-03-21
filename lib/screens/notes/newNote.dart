import 'package:flutter/material.dart';
import 'package:notes_app/screens/home.dart';
import 'package:notes_app/widgets/custom_appbar.dart';
import 'package:notes_app/widgets/custom_textbox_borderless.dart';
import 'package:page_transition/page_transition.dart';

import '../../styles.dart';
import '../../widgets/dialog/saveDiscardPopup.dart';

class NewNote extends StatefulWidget {
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextAlign textAlign = TextAlign.left;
  double fontSize = 18;
  String selectedIconIndex = "0";

  @override
  void initState() {
    super.initState();
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
          onPress: () {
            saveDiscardPopup(context);
          },
          navLocation: HomeScreen(),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return !await saveDiscardPopup(context);
        },
        child: GestureDetector(
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
                  CustomTextBoxBorderLess(
                    controller: titleController,
                    labelText: "Title",
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
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
        ),
      ),
    );
  }
}
