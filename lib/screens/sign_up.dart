import 'package:expense_tracker/core/app_color.dart';
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
  bool passwordVisible = false;


  void initState() {
    super.initState();
    dbHelper = DbHelper();
    passwordVisible = true;
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
        backgroundColor: AppColor.colorWhite,
        elevation: 0,
        leading: InkWell(
          child: Icon(Icons.arrow_back,color: AppColor.colorBlue,),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),

      ),
      body:SingleChildScrollView(
        child: Container(
          height:700,
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
                      AppString.textCreateAnAccount,
                      style: getTextStyle(AppFonts.semiBold, AppSize.textSize25),
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
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_2_outlined,color: AppColor.colorBlue,),
                            filled: true,
                            border: OutlineInputBorder(  borderRadius: BorderRadius.circular(30)),
                            hintText: AppString.textFullName,
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
                            prefixIcon: Icon(Icons.email_outlined,color: AppColor.colorBlue,),
                            filled: true,
                            border: OutlineInputBorder(  borderRadius: BorderRadius.circular(30)),
                            hintText: AppString.textEmailAddress,
                            hintStyle:
                            getTextStyle(AppFonts.regularGrey, AppSize.textSize15),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          obscureText: passwordVisible,
                          controller: passwordController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline_sharp,color: AppColor.colorBlue,),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)
                            ),
                            hintText: AppString.textPassword,
                            hintStyle:
                            getTextStyle(AppFonts.regularGrey, AppSize.textSize15),
                              suffixIcon: IconButton(
                                icon: Icon(passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });

                                },
                              )
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                            height: 50,
                            width:270,
                            child: ElevatedButton(
                              onPressed: () {
                                SignUp();
                                storeInDb();
                              },
                              child: Text(AppString.textREGISTER),style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /*Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_2_outlined,color: AppColor.colorBlue,),
                filled: true,
                border: OutlineInputBorder(  borderRadius: BorderRadius.circular(30)),
                hintText: AppString.textFullName,
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
                prefixIcon: Icon(Icons.email_outlined,color: AppColor.colorBlue,),
                filled: true,
                border: OutlineInputBorder(  borderRadius: BorderRadius.circular(30)),
                hintText: AppString.textEmailAddress,
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
                prefixIcon: Icon(Icons.lock_outline_sharp,color: AppColor.colorBlue,),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                hintText: AppString.textPassword,
                hintStyle:
                    getTextStyle(AppFonts.regularGrey, AppSize.textSize15),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
                height: 50,
                width:270,
                child: ElevatedButton(
                    onPressed: () {
                      SignUp();
                      storeInDb();
                    },
                    child: Text(AppString.textREGISTER),style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),)),
          ],
        ),
      ),*/
    );
  }
}
