import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_app/screens/onBoarding/login.dart';

import 'package:notes_app/styles.dart';

// import '../home.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: double.infinity,
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
