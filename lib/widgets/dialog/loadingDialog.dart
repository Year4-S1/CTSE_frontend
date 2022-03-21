import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../styles.dart';

loadingDialog(BuildContext context) {
  return Center(
    child: Container(
      height: 150.0,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SpinKitRing(
            color: defaultColor,
            lineWidth: 1.5,
            size: 35.0,
          ),
          const SizedBox(height: 40),
          Text("Loading...", style: greyNormalTextStyle),
        ],
      ),
    ),
  );
}
