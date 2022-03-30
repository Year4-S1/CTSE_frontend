import 'package:noteworthy/api/api_calls.dart';
import 'package:noteworthy/utils/helper.dart';
import 'package:noteworthy/utils/settings.dart';
import 'package:noteworthy/widgets/custom_textbox.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../screens/home.dart';
import '../../styles.dart';

updatePasswordPopup(BuildContext context, TextEditingController oldPassword,
    TextEditingController newPassword) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  final formKey = GlobalKey<FormState>();
  String token;

  clear() {
    oldPassword.text = "";
    newPassword.text = "";
  }

  update(String newPassword, String oldPassword) async {
    token = (await Settings.getAccessToken())!;

    if (formKey.currentState!.validate()) {
      final response = await ApiCalls.forgotPassword(
          token: token, oldPassword: oldPassword, newPassword: newPassword);

      var json = response.jsonBody;

      if (response.isSuccess) {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop, child: HomeScreen()));
        snackBar("Successful", context);
      } else {
        Navigator.pop(context);
        snackBar("Failed, check password", context);
      }
    }
    clear();
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          height: height - 460,
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
                padding: EdgeInsets.only(top: 40, bottom: 40),
                child: Text(
                  "Update Password",
                  style: HeaderStyle,
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextBox(
                      controller: oldPassword,
                      labelText: "Enter old password",
                      obscureText: true,
                      validator: (oldPassword) {
                        if (oldPassword.isEmpty) {
                          return "Field cannot be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextBox(
                      controller: newPassword,
                      labelText: "Enter new password",
                      obscureText: true,
                      validator: (newPassword) {
                        if (newPassword.isEmpty) {
                          return "Field cannot be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
                  ],
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
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: 140,
                          alignment: Alignment.center,
                          child: Text("Back", style: greyNormalTextStyle)),
                    ),
                    GestureDetector(
                      onTap: () {
                        update(newPassword.text, oldPassword.text);
                      },
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
