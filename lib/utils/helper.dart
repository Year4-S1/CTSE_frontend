import 'package:flutter/material.dart';

import '../styles.dart';

snackBar(String? message, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message!),
      duration: const Duration(seconds: 2),
    ),
  );
}

noteColorSetter(String color) {
  switch (color) {
    case "pink":
      return notePink;
    case "purple":
      return notePurple;
    case "blue":
      return noteBlue;
    case "green":
      return noteGreen;
    case "yellow":
      return noteYellow;
    case "orange":
      return noteOrange;
    default:
      return noteUnassigned;
  }
}

iconColorSetter(String color) {
  switch (color) {
    case "pink":
      return catagoryPink;
    case "purple":
      return catagoryPurple;
    case "blue":
      return catagoryBlue;
    case "green":
      return catagoryGreen;
    case "yellow":
      return catagoryYellow;
    case "orange":
      return catagoryOrange;
    default:
      return catagoryUnassigned;
  }
}
