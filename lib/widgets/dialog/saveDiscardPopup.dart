import 'package:flutter/material.dart';
import '../../styles.dart';

saveDiscardPopup(BuildContext context, String type, dynamic Function() save,
    dynamic Function() discard) {
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
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  'Discard $type?',
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
                      onTap: discard,
                      child: Container(
                          width: 140,
                          alignment: Alignment.center,
                          child: Text("Discard", style: greyNormalTextStyle)),
                    ),
                    GestureDetector(
                      onTap: save,
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
