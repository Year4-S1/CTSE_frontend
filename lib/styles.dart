import 'package:flutter/material.dart';

const defaultColor = Color(0xFF2980B9);
const inactiveColor = Color(0xFFCFCFCF);
const whiteColor = Colors.white;
const errorColor = Color.fromARGB(255, 230, 15, 0);

// Catagory colors
const catagoryPink = Color.fromARGB(255, 252, 75, 137);
const catagoryPurple = Color.fromARGB(255, 183, 66, 204);
const catagoryBlue = Color.fromARGB(255, 86, 160, 240);
const catagoryGreen = Color.fromARGB(255, 152, 219, 19);
const catagoryYellow = Color.fromARGB(255, 235, 196, 23);
const catagoryOrange = Color.fromARGB(255, 226, 109, 31);
const catagoryUnassigned = Colors.black26;

// Noted colors
const notePink = Color(0xFFFFCFE0);
const notePurple = Color(0xFFC493CD);
const noteBlue = Color(0xFFA7CDF5);
const noteGreen = Color(0xFFD9F79D);
const noteYellow = Color(0xFFF9F192);
const noteOrange = Color(0xFFF7C990);
const noteUnassigned = Colors.black12;

//Fonts and text
const String defaultFont = 'Josefin Sans';

const SplashLogoText = TextStyle(
    color: defaultColor,
    fontFamily: defaultFont,
    fontSize: 40,
    fontWeight: FontWeight.bold);

const LogoText = TextStyle(
    fontFamily: defaultFont,
    color: defaultColor,
    fontWeight: FontWeight.w900,
    fontSize: 25.0);

const HeaderStyle = TextStyle(
    fontFamily: defaultFont,
    color: defaultColor,
    fontSize: 20.0,
    fontWeight: FontWeight.bold);

const HeaderStyle2 = TextStyle(
    fontFamily: defaultFont,
    color: Colors.black38,
    fontWeight: FontWeight.w500,
    fontSize: 18.0);

const HeaderStyle3 = TextStyle(
    fontFamily: defaultFont,
    color: Colors.black87,
    fontWeight: FontWeight.bold,
    fontSize: 24.0);

const SubHeadStyle = TextStyle(
    color: Color(0xFF858585), fontWeight: FontWeight.w500, fontSize: 18);

const LabelStyle1 = TextStyle(
    fontFamily: defaultFont,
    color: Color(0XFFABABAB),
    fontWeight: FontWeight.w500,
    fontSize: 18.0);

const errorStyle = TextStyle(
    fontFamily: defaultFont,
    color: errorColor,
    fontWeight: FontWeight.w400,
    fontSize: 14.0);

const HintStyle1 = TextStyle(
    fontFamily: defaultFont,
    color: Color(0XFFABABAB),
    fontWeight: FontWeight.w500,
    fontSize: 15.0);

const SeeAllStyle =
    TextStyle(fontFamily: defaultFont, color: defaultColor, fontSize: 16.0);

TextStyle greyNormalTextStyle = const TextStyle(
    color: Colors.grey, fontSize: 18.0, height: 1.3, fontFamily: defaultFont);

const LogOut = TextStyle(
    fontFamily: defaultFont,
    color: Colors.red,
    fontWeight: FontWeight.w600,
    fontSize: 18.0);

const TextButtonStyle = TextStyle(
  fontFamily: defaultFont,
  color: Color(0xFFAFB0B1),
  fontSize: 12.0,
);
