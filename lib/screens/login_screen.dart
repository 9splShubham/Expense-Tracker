import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_fonts.dart';
import 'package:expense_tracker/core/app_size.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/core/com_helper/com_helper.dart';
import 'package:expense_tracker/screens/dashboard.dart';
import 'package:expense_tracker/screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  void Login() async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .catchError((error) {
      print(error);
      alertDialog("Error: Data Save Fail--$error");
    }).then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }).then((value) {
      alertDialog(AppString.textSuccessfullyLoggedIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 800,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            AppColor.colorDarkBlue,
            AppColor.colorBlue,
            AppColor.colorLightBlue,
          ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      AppString.textLOGIN,
                      style: getTextStyle(AppFonts.semiBold, AppSize.textSize25),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppString.textWelcome,
                      style: getTextStyle(AppFonts.regular, AppSize.textSize15),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.colorWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: AppColor.colorBlue,
                            ),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            hintText: AppString.textEmailAddress,
                            hintStyle: getTextStyle(
                                AppFonts.regularGrey, AppSize.textSize15),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          obscureText: passwordVisible,
                          controller: passwordController,
                          decoration: InputDecoration(

                              prefixIcon: Icon(
                                Icons.lock_outline_sharp,
                                color: AppColor.colorBlue,
                              ),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintText: AppString.textPassword,
                              hintStyle: getTextStyle(
                                  AppFonts.regularGrey, AppSize.textSize15),
                              suffixIcon: IconButton(
                                icon: Icon(passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });

                                },
                              )),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                            height: 50,
                            width: 270,
                            child: ElevatedButton(
                                onPressed: () {
                                  Login();
                                },
                                child: Text(AppString.textLOGIN),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))))),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          child: Container(
                            child: Text.rich(TextSpan(children: [
                              TextSpan(
                                text: AppString.textDonthaveanaccount,
                                style: getTextStyle(
                                    AppFonts.regularBlack, AppSize.textSize15),
                              ),
                              TextSpan(
                                text: AppString.textRegisterNow,
                                style: getTextStyle(
                                    AppFonts.regularBlue, AppSize.textSize15),
                              )
                            ])),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
