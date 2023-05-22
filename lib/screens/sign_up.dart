import 'package:expense_tracker/core/app_size.dart';
import 'package:expense_tracker/core/com_helper/com_helper.dart';
import 'package:expense_tracker/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
        title: const Text("SIGN UP"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextField(
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(),
                hintText: "Full Name",
                hintStyle: TextStyle(fontSize: AppSize.textSize15),
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
                hintText: "Email Address",
                hintStyle: TextStyle(fontSize: AppSize.textSize15),
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
                hintText: "Password",
                hintStyle: TextStyle(fontSize: AppSize.textSize15),
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
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                          .catchError((error) {
                        print(error);
                        alertDialog("Error: Data Save Fail--$error");
                      }).then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      }).then((value) {
                        alertDialog("Successfully Registered");
                      });
                    },
                    child: Text("Sign Up"))),
          ],
        ),
      ),
    );
  }
}
