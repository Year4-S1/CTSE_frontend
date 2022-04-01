import 'package:noteworthy/screens/onBoarding/otp_verify.dart';
import 'package:noteworthy/widgets/dialog/loadingDialog.dart';
import 'package:noteworthy/widgets/custom_textbox.dart';
import 'package:noteworthy/widgets/custom_appbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:noteworthy/api/api_calls.dart';
import 'package:noteworthy/screens/home.dart';
import '../../styles.dart';
import '../../utils/helper.dart';
import '../../widgets/custom_button.dart';
import 'package:flutter/material.dart';
import '../../utils/settings.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool shouldPop = false; //to make sure can't go back
  final formKey = GlobalKey<FormState>();
  bool loaded = true;

  @override
  void initState() {
    super.initState();
  }

  loginRegister() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        loaded = false;
      });
      final response = await ApiCalls.signInUp(
          email: emailController.text, password: passwordController.text);

      var json = response.jsonBody;

      setState(() {
        loaded = true;
      });

      if (json['message'] == "OTP Sent") {
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: OtpVerifyScreen(
                  emailController.text, passwordController.text)),
        );
      } else if (json['message'] == "Valid password") {
        var json = response.jsonBody;
        await Settings.setSigned(true);
        String accessToken = json['token'];
        await Settings.setAccessToken(accessToken);
        String userId = json['id'];
        await Settings.setUserID(userId);
        await Settings.setUserEmail(emailController.text);

        snackBar("Welcome", context);
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: HomeScreen()));
      } else if (json['error'] == "Invalid Password") {
        snackBar("Invalid password", context);
      } else {
        snackBar("Something went wrong", context);
      }
    }
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
          rightIcon: "",
          navLocation: LoginScreen(),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return shouldPop;
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: loaded
              ? Container(
                  height: height,
                  width: width,
                  color: whiteColor,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
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
                            controller: emailController,
                            labelText: "Enter email address",
                            keyboardType: TextInputType.emailAddress,
                            validator: (emailController) {
                              if (emailController.isEmpty) {
                                return "Field cannot be empty";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextBox(
                            controller: passwordController,
                            labelText: "Enter password",
                            obscureText: true,
                            validator: (passwordController) {
                              if (passwordController.isEmpty) {
                                return "Field cannot be empty";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              loginRegister();
                            },
                            child: CustomButton(
                              text: "Login",
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
                )
              : loadingDialog(context),
        ),
      ),
    );
  }
}
