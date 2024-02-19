// ignore_for_file: unused_local_variable, file_names, camel_case_types, avoid_print

import 'package:bookstore_app/firebase_auth/fireabse_auth_services.dart';
import 'package:bookstore_app/pages/signin_page.dart';
import 'package:bookstore_app/pages/landing_page.dart';
import 'package:bookstore_app/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final FirebaseAuthSeervices auth = FirebaseAuthSeervices();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        //appBar: AppBar(title: Text("Log In")),
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text("Log In",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: size.width * 0.07)),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        MyTextField(
          hint: 'email',
          obscuretext: false,
          textcontroller: emailController,
        ),
        MyTextField(
          hint: 'passowrd',
          obscuretext: true,
          textcontroller: passwordController,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: signIn,
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  child: const Text("Log In"),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Get.to(const CreateUserPage(),
                        transition: Transition.leftToRight);
                  },
                  child: Row(
                    children: [
                      const Text("If you don't have an account"),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      const Text("Sign up",
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline)),
                    ],
                  )),
            ],
          ),
        )
      ],
    ));
  }

  void signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await auth.signInWithEmailAndPassword(email, password);
    if (user != null) {
      print("user is Successfully log in");
      Get.to(LandingPage(), transition: Transition.rightToLeft);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Enter conrrect credentials",
          ),
          content: const Text(
            "please, enter correct email and password",
          ),
          contentPadding: EdgeInsets.all(10),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "close",
              ),
            ),
          ],
        ),
      );
    }
  }
}
