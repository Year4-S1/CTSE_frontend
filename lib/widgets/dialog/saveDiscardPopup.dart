import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import '../../screens/home.dart';
import '../../styles.dart';

saveDiscardPopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          height: 150.0,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  "Discard Note?",
                  style: LogOut,
                ),
              ),
              SizedBox(
                height: 40.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.topToBottom,
                                child: HomeScreen()));
                      },
                      child: Container(
                          width: 140,
                          alignment: Alignment.center,
                          child: Text("Discard", style: greyNormalTextStyle)),
                    ),
                    GestureDetector(
                      child: Container(
                          width: 140,
                          alignment: Alignment.center,
                          child: const Text("Save", style: SeeAllStyle)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
