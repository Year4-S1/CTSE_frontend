import 'package:flutter/material.dart';
import 'package:noteworthy/api/api_calls.dart';
import 'package:noteworthy/screens/home.dart';
import 'package:noteworthy/utils/settings.dart';
import 'package:noteworthy/widgets/custom_appbar.dart';
import 'package:noteworthy/widgets/custom_button.dart';
import 'package:noteworthy/widgets/custom_textbox_borderless.dart';
import 'package:noteworthy/widgets/dialog/loadingDialog.dart';
import 'package:page_transition/page_transition.dart';

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
  Map<dynamic, dynamic> postCatagories = {};

  String? userId;

  bool shouldPop = true;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    userId = await Settings.getUserID();
    var res = await ApiCalls.getCatagories(userId: userId!);

    catagoryList = res.jsonBody;

    setState(() {
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

      loaded = true;
    });
  }

  postCatagory() async {
    setState(() {
      loaded = false;
    });

    postCatagories = {
      "pink": pinkController.text,
      "purple": purpleController.text,
      "blue": blueController.text,
      "green": greenController.text,
      "yellow": yellowController.text,
      "orange": orangeController.text,
      "unassigned": ""
    };

    if (postCatagories.isNotEmpty) {
      var res = await ApiCalls.postCatagories(
          catagories: postCatagories, userId: userId!);

      var json = res.jsonBody;
      print(json);

      setState(() {
        loaded = true;
      });

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.bottomToTop, child: HomeScreen()));
    }
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
                          postCatagory();
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
}
