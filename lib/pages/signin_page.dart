// ignore_for_file: unused_import, camel_case_types, avoid_unnecessary_containers, unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:bookstore_app/components/text_field.dart';
import 'package:bookstore_app/controller/user_controller.dart';
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
  final auth1 = FirebaseAuth.instance;

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
              child: Text(
                "Create User",
                style: TextStyle(
                  fontSize: size.width * 0.07,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MyTextField(
              hint: "User Name",
              obscuretext: false,
              textcontroller: userNameController,
            ),
            MyTextField(
              hint: "Email",
              obscuretext: false,
              textcontroller: emailController,
            ),
            MyTextField(
              hint: "Password",
              obscuretext: true,
              textcontroller: passwordController,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.02,
                top: size.width * 0.02,
                right: size.width * 0.02,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        userRegister(
                          emailController.text,
                          passwordController.text,
                          userNameController.text,
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Sign up",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Row(
                      children: [
                        Text("If you have an account"),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void userRegister(String email, String password, String uname) async {
    User? user = await createUserWithEmailAndPassword(email, password);

    if (user != null) {
      UserController()
          .addUser(user: user, uname: uname, email: email, id: user.uid);
      Get.to(LandingPage());
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Failed to create user: ${e.message}');
      if (6 > password.length) {
        popupMessage("Password should be at least 6 characters", "");
      }
    }

    bool isEmailValid(String email) {
      // Regular expression for a valid email address
      final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      return emailRegex.hasMatch(email);
    }

    if (!isEmailValid(email)) {
      popupMessage("Enter valid email", "");
    }

    return null;
  }

  Future<dynamic> popupMessage(String title, String content) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
        ),
        content: Text(
          content,
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
