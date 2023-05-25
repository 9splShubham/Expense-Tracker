import 'package:expense_tracker/core/app_config.dart';
import 'package:expense_tracker/core/app_fonts.dart';
import 'package:expense_tracker/core/app_size.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/core/com_helper/com_helper.dart';
import 'package:expense_tracker/db_helper/db_helper.dart';
import 'package:expense_tracker/model/model.dart';
import 'package:expense_tracker/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  late DbHelper dbHelper;

  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void SignUp() async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .catchError((error) {
      print(error);
      alertDialog("Error: Data Save Fail--$error");
    }).then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(AppConfig.textUserId, value.user!.uid);
      print("ID-------->${prefs.getString(AppConfig.textUserId)}");
    }).then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }).then((value) {
      alertDialog(AppString.textSuccessfullyRegistered);
    });
  }

  void storeInDb() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    SignUpModel sModel = SignUpModel();

    sModel.name = name;
    sModel.email = email;
    sModel.password = password;
    sModel.userId = sp.getString(AppConfig.textUserId);

    dbHelper = DbHelper();
    await dbHelper.saveSignUpData(sModel).catchError((error) {
      print('${error}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
        title: const Text(AppString.textSIGNUP),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(),
                labelText: AppString.textFullName,
                hintStyle:
                    getTextStyle(AppFonts.regularGrey, AppSize.textSize15),
              ),
            ),
            SizedBox(
              height: 20,
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
                      SignUp();
                      storeInDb();
                    },
                    child: Text(AppString.textSIGNUP))),
          ],
        ),
      ),
    );
  }
}
