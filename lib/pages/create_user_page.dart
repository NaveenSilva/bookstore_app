// ignore_for_file: unused_import, camel_case_types, avoid_unnecessary_containers, unused_local_variable, avoid_print

import 'package:bookstore_app/components/text_field.dart';
import 'package:bookstore_app/firebase_auth/fireabse_auth_services.dart';
import 'package:bookstore_app/pages/HomePage.dart';
import 'package:bookstore_app/pages/logInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class create_user_page extends StatefulWidget {
  const create_user_page({super.key});

  @override
  State<create_user_page> createState() => _create_user_pageState();
}

class _create_user_pageState extends State<create_user_page> {
  final FirebaseAuthSeervices auth = FirebaseAuthSeervices();

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text("Create User",
                    style: TextStyle(fontSize: size.width * 0.07))),
            const SizedBox(
              height: 15,
            ),
            myTextField(
                hint: "User Name",
                obscuretext: false,
                textcontroller: userNameController),
            myTextField(
                hint: "Email",
                obscuretext: false,
                textcontroller: emailController),
            myTextField(
                hint: "Password",
                obscuretext: true,
                textcontroller: passwordController),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: signUp,
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      child: const Text("Sign up"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Text("If you have an account",
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void signUp() async {
    String uname = userNameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print("user is Successfully cerated");
      Get.to(HomePage(), transition: Transition.rightToLeft);
    } else {
      AlertDialog(
          title: const Text("Some Error Occured"),
          content: const Text("data"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("close"))
          ]);
    }
  }
}
