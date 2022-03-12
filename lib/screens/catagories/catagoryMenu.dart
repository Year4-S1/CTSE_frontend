import 'package:flutter/material.dart';
import 'package:notes_app/screens/home.dart';
import 'package:notes_app/widgets/custom_appbar.dart';
import 'package:notes_app/widgets/custom_button.dart';
import 'package:notes_app/widgets/custom_textbox_borderless.dart';

import '../../styles.dart';

class CatagoryMenuScreen extends StatefulWidget {
  _CatagoryMenuScreenState createState() => _CatagoryMenuScreenState();
}

class _CatagoryMenuScreenState extends State<CatagoryMenuScreen> {
  bool shouldPop = true;
  TextEditingController red = TextEditingController();
  TextEditingController orange = TextEditingController();
  TextEditingController purple = TextEditingController();
  TextEditingController blue = TextEditingController();
  TextEditingController green = TextEditingController();

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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: CustomAppbarWidget(
            mainTitle: "Noteworthy",
            leading: "Navigate",
            navLocation: HomeScreen(),
            logo: true,
            save: false,
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: width,
            padding: EdgeInsets.all(10),
            child: ListView(
              padding: EdgeInsets.all(10),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: const Text(
                    "Assign Bookmark",
                    style: SubHeadStyle,
                  ),
                ),
                CustomTextBoxBorderLess(
                  controller: red,
                  labelText: "Red Bookmark",
                  prifixIcon: const Icon(
                    Icons.bookmark_add,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextBoxBorderLess(
                  controller: orange,
                  labelText: "Orange Bookmark",
                  prifixIcon: Icon(
                    Icons.bookmark_add,
                    color: Colors.orange[600],
                    size: 30,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextBoxBorderLess(
                  controller: purple,
                  labelText: "Purple Bookmark",
                  prifixIcon: Icon(
                    Icons.bookmark_add,
                    color: Colors.purple[400],
                    size: 30,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextBoxBorderLess(
                  controller: blue,
                  labelText: "Blue Bookmark",
                  prifixIcon: Icon(
                    Icons.bookmark_add,
                    color: Colors.blue[300],
                    size: 30,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextBoxBorderLess(
                  controller: green,
                  labelText: "Green Bookmark",
                  prifixIcon: Icon(
                    Icons.bookmark_add,
                    color: Colors.green[300],
                    size: 30,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 200),
                  child: CustomButton(
                    text: "Done",
                    width: width - 60,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
