import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noteworthy/screens/home.dart';
import 'package:noteworthy/screens/onBoarding/login.dart';

import 'package:noteworthy/styles.dart';
import 'package:noteworthy/utils/settings.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navChecker();
  }

  navChecker() async {
    bool? checker = await Settings.getSigned();
    checker == null ? checker == false : null;

    if (checker!) {
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      });
    } else {
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: whiteColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Noteworthy", style: SplashLogoText),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/banner.gif",
                  height: 300.0,
                  width: 300.0,
                ),
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "The one stop worth a Note",
                  style: HeaderStyle2,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
