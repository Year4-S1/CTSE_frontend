import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes_app/api/api_calls.dart';
import 'package:notes_app/screens/home.dart';
import 'package:notes_app/utils/settings.dart';
import 'package:notes_app/widgets/custom_appbar.dart';
import 'package:notes_app/widgets/custom_button.dart';
import 'package:notes_app/widgets/custom_textbox_borderless.dart';
import 'package:notes_app/widgets/dialog/loadingDialog.dart';

import '../../styles.dart';

class CatagoryMenuScreen extends StatefulWidget {
  _CatagoryMenuScreenState createState() => _CatagoryMenuScreenState();
}

class _CatagoryMenuScreenState extends State<CatagoryMenuScreen> {
  TextEditingController pinkController = TextEditingController();
  TextEditingController purpleController = TextEditingController();
  TextEditingController blueController = TextEditingController();
  TextEditingController greenController = TextEditingController();
  TextEditingController yellowController = TextEditingController();
  TextEditingController orangeController = TextEditingController();

  Map<String, dynamic> catagoryList = {};
  Map<dynamic, dynamic> updateCatagory = {};
  Map<dynamic, dynamic> createCatagory = {};

  String? token;

  bool shouldPop = true;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    token = await Settings.getAccessToken();
    var res = await ApiCalls.getCatagories(token: token!);

    catagoryList = res.jsonBody;

    if (catagoryList['data'] != null) {
      for (int i = 0; i < catagoryList['data'].length; i++) {
        switch (catagoryList['data'][i]['categoryColor']) {
          case "pink":
            pinkController.text = catagoryList['data'][i]['categoryName'];
            break;
          case "purple":
            purpleController.text = catagoryList['data'][i]['categoryName'];
            break;
          case "blue":
            blueController.text = catagoryList['data'][i]['categoryName'];
            break;
          case "green":
            greenController.text = catagoryList['data'][i]['categoryName'];
            break;
          case "yellow":
            yellowController.text = catagoryList['data'][i]['categoryName'];
            break;
          case "orange":
            orangeController.text = catagoryList['data'][i]['categoryName'];
            break;
          default:
        }
      }
    }

    setState(() {
      loaded = true;
    });
  }

  postCatagory() async {
    print("post cat came here");

    if (createCatagory.isNotEmpty) {
      print("post cat came createCatagory" + createCatagory.toString());
      var res = await ApiCalls.postCatagories(
          catagories: createCatagory, token: token!);

      var json = res.jsonBody;
      print(json);
    }
    if (updateCatagory.isNotEmpty) {
      print("post cat came updateCatagory" + updateCatagory.toString());
      var res = await ApiCalls.updateCatagories(
          catagories: updateCatagory, token: token!);
      var json = res.jsonBody;
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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: CustomAppbarWidget(
            mainTitle: "Noteworthy",
            leading: "Navigate",
            navLocation: HomeScreen(),
            logo: true,
            rightIcon: "",
          ),
        ),
        body: loaded
            ? GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  height: height,
                  width: width,
                  padding: const EdgeInsets.all(10),
                  child: ListView(
                    padding: const EdgeInsets.all(10),
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: const Text(
                          "Assign Bookmark",
                          style: SubHeadStyle,
                        ),
                      ),
                      CustomTextBoxBorderLess(
                        controller: pinkController,
                        labelText: "Pink Bookmark",
                        prifixIcon: const Icon(
                          Icons.bookmark_add,
                          color: catagoryPink,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextBoxBorderLess(
                        controller: purpleController,
                        labelText: "Purple Bookmark",
                        prifixIcon: const Icon(
                          Icons.bookmark_add,
                          color: catagoryPurple,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextBoxBorderLess(
                        controller: blueController,
                        labelText: "Blue Bookmark",
                        prifixIcon: const Icon(
                          Icons.bookmark_add,
                          color: catagoryBlue,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextBoxBorderLess(
                        controller: greenController,
                        labelText: "Green Bookmark",
                        prifixIcon: const Icon(
                          Icons.bookmark_add,
                          color: catagoryGreen,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextBoxBorderLess(
                        controller: yellowController,
                        labelText: "Yellow Bookmark",
                        prifixIcon: const Icon(
                          Icons.bookmark_add,
                          color: catagoryYellow,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextBoxBorderLess(
                        controller: orangeController,
                        labelText: "Orange Bookmark",
                        prifixIcon: const Icon(
                          Icons.bookmark_add,
                          color: catagoryOrange,
                          size: 30,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          catagoryChecker();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 150),
                          child: CustomButton(
                            text: "Done",
                            width: width - 60,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : loadingDialog(context),
      ),
    );
  }

  catagoryChecker() async {
    setState(() {
      loaded = false;
    });
    print(catagoryList['data']);
    if (catagoryList['data'].length > 0) {
      for (int i = 0; i < catagoryList['data'].length; i++) {
        switch (catagoryList['data'][i]['categoryColor']) {
          case "pink":
            updateCatagory["pink"] = pinkController.text;
            break;
          case "purple":
            updateCatagory["purple"] = purpleController.text;
            break;
          case "blue":
            updateCatagory["blue"] = blueController.text;
            break;
          case "green":
            updateCatagory["green"] = greenController.text;
            break;
          case "yellow":
            updateCatagory["yellow"] = yellowController.text;
            break;
          case "orange":
            updateCatagory["orange"] = orangeController.text;
            break;
          default:
        }

        if (catagoryList['data'][i]['categoryColor'] != "pink" &&
            pinkController.text != "") {
          createCatagory["pink"] = pinkController.text;
        } else if (catagoryList['data'][i]['categoryColor'] != "purple" &&
            purpleController.text != "") {
          createCatagory["purple"] = purpleController.text;
        } else if (catagoryList['data'][i]['categoryColor'] != "blue" &&
            blueController.text != "") {
          createCatagory["blue"] = blueController.text;
        } else if (catagoryList['data'][i]['categoryColor'] != "green" &&
            greenController.text != "") {
          createCatagory["green"] = greenController.text;
        } else if (catagoryList['data'][i]['categoryColor'] != "yellow" &&
            yellowController.text != "") {
          createCatagory["yellow"] = yellowController.text;
        } else if (catagoryList['data'][i]['categoryColor'] != "orange" &&
            orangeController.text != "") {
          createCatagory["orange"] = orangeController.text;
        } else {
          null;
        }
      }
    } else {
      if (pinkController.text != "") {
        createCatagory["pink"] = pinkController.text;
      } else if (purpleController.text != "") {
        createCatagory["purple"] = purpleController.text;
      } else if (blueController.text != "") {
        createCatagory["blue"] = blueController.text;
      } else if (greenController.text != "") {
        createCatagory["green"] = greenController.text;
      } else if (yellowController.text != "") {
        createCatagory["yellow"] = yellowController.text;
      } else if (orangeController.text != "") {
        createCatagory["orange"] = orangeController.text;
      } else {
        null;
      }
    }
    postCatagory();
  }
}
