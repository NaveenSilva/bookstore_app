// ignore_for_file: unused_import, camel_case_types, avoid_unnecessary_containers, unused_local_variable, avoid_print

import 'package:bookstore_app/components/text_field.dart';
import 'package:bookstore_app/firebase_auth/fireabse_auth_services.dart';
import 'package:bookstore_app/pages/landing_page.dart';
import 'package:bookstore_app/pages/logIn_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
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
            MyTextField(
                hint: "User Name",
                obscuretext: false,
                textcontroller: userNameController),
            MyTextField(
                hint: "Email",
                obscuretext: false,
                textcontroller: emailController),
            MyTextField(
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
      Get.to(LandingPage(), transition: Transition.rightToLeft);
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
