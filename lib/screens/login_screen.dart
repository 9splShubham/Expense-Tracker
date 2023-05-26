import 'package:expense_tracker/core/app_config.dart';
import 'package:expense_tracker/core/app_fonts.dart';
import 'package:expense_tracker/core/app_size.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/core/com_helper/com_helper.dart';
import 'package:expense_tracker/screens/dashboard.dart';
import 'package:expense_tracker/screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppString.textLOGIN),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(),
                labelText: AppString.textEmailAddress,
                hintStyle:
                    getTextStyle(AppFonts.regularGrey, AppSize.textSize15),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(),
                labelText: AppString.textPassword,
                hintStyle:
                    getTextStyle(AppFonts.regularGrey, AppSize.textSize15),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Login();
                    },
                    child: Text(AppString.textLOGIN))),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Container(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: AppString.textDonthaveanaccount,
                    style:
                        getTextStyle(AppFonts.regularBlack, AppSize.textSize15),
                  ),
                  TextSpan(
                    text: AppString.textRegisterNow,
                    style:
                        getTextStyle(AppFonts.regularBlue, AppSize.textSize15),
                  )
                ])),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
            )
          ],
        ),
      ),
    );
  }
}
