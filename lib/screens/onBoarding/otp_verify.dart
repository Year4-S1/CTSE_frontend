import 'dart:async';

import 'package:noteworthy/api/api_calls.dart';
import 'package:noteworthy/screens/home.dart';
import 'package:noteworthy/styles.dart';
import 'package:noteworthy/widgets/dialog/loadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';

import '../../utils/helper.dart';
import '../../utils/settings.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import 'login.dart';

class OtpVerifyScreen extends StatefulWidget {
  final String email;
  final String password;

  OtpVerifyScreen(this.email, this.password, {Key? key}) : super(key: key);
  @override
  _OtpVerifyScreen createState() => _OtpVerifyScreen();
}

class _OtpVerifyScreen extends State<OtpVerifyScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  final formKey = GlobalKey<FormState>();
  String currentText = "";
  bool hasError = false;
  bool loaded = true;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  verify() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        loaded = false;
      });
      final response =
          await ApiCalls.verifyOtp(otp: textEditingController.text);

      var json = response.jsonBody;

      setState(() {
        loaded = true;
      });

      if (response.isSuccess) {
        if (json['message'] == "Registration Successfull") {
          var json = response.jsonBody;
          await Settings.setSigned(true);
          String accessToken = json['token'];
          await Settings.setAccessToken(accessToken);
          String userId = json['id'];
          await Settings.setAccessToken(userId);
          await Settings.setUserEmail(widget.email);

          snackBar("OTP Verified!", context);
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: HomeScreen()),
          );
        }
      } else {
        snackBar("Something went wrong", context);
      }
    }
  }

  resendOtp() async {
    snackBar("Processing", context);
    final response =
        await ApiCalls.signInUp(email: widget.email, password: widget.password);

    var json = response.jsonBody;

    if (json['message'] == "OTP Sent") {
      snackBar("OTP sent!", context);
    } else {
      snackBar("Something went wrong", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: CustomAppbarWidget(
          mainTitle: "Noteworthy",
          leading: "None",
          logo: true,
          rightIcon: "",
          navLocation: LoginScreen(),
        ),
      ),
      backgroundColor: whiteColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: loaded
            ? Container(
                height: height,
                width: width,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 100),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Enter the code sent to',
                        style: HeaderStyle3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 8),
                      child: Text(
                        widget.email,
                        style: HeaderStyle2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 30),
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 6,
                            obscureText: true,
                            blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.length < 6) {
                                return null;
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                              activeColor: defaultColor,
                              selectedFillColor: Colors.white,
                              selectedColor: Colors.black45,
                              inactiveFillColor: Colors.white,
                              inactiveColor: Colors.black26,
                              disabledColor: Colors.black26,
                              errorBorderColor: errorColor,
                            ),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            keyboardType: TextInputType.number,
                            onCompleted: (v) {
                              print("Completed");
                            },
                            onChanged: (value) {
                              setState(() {
                                currentText = value;
                              });
                            },
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        hasError
                            ? "* Please fill up all the cells properly"
                            : "",
                        style: const TextStyle(
                            color: errorColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't receive the code? ",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                        TextButton(
                            onPressed: () {
                              resendOtp();
                            },
                            child: const Text(
                              "RESEND",
                              style: TextStyle(
                                  color: defaultColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    CustomButton(
                      text: "Done",
                      width: width - 60,
                      onTap: () {
                        formKey.currentState!.validate();

                        if (currentText.length != 6) {
                          errorController!.add(ErrorAnimationType.shake);
                          setState(() => hasError = true);
                        } else {
                          setState(
                            () {
                              hasError = false;
                              verify();
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              )
            : loadingDialog(context),
      ),
    );
  }
}
