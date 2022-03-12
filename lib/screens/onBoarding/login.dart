import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/screens/home.dart';
import 'package:notes_app/widgets/custom_appbar.dart';
import 'package:notes_app/widgets/custom_textbox.dart';

import 'package:page_transition/page_transition.dart';

import '../../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

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
            leading: "None",
            logo: true,
            save: false,
            navLocation: LoginScreen(),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: height,
            width: width,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/login-banner.jpg",
                    height: 300.0,
                    width: 300.0,
                  ),
                  CustomTextBox(
                    controller: userName,
                    labelText: "Enter Username",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextBox(
                    controller: password,
                    labelText: "Enter Password",
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CustomButton(
                      text: "Login",
                      width: width - 60,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: HomeScreen()));
                    },
                    child: CustomButton(
                      text: "Continue without Login",
                      width: width - 60,
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
