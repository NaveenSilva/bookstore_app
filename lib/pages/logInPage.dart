import 'package:bookstore_app/pages/HomePage.dart';
import 'package:bookstore_app/pages/create_user_page.dart';
import 'package:bookstore_app/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class logInPage extends StatelessWidget {
  const logInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
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
        const myTextField(hint: 'email'),
        const myTextField(hint: 'passowrd'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(HomePage(), transition: Transition.rightToLeft);
                  },
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  child: const Text("Log In"),
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
                    Get.to(create_user_page(),
                        transition: Transition.leftToRight);
                  },
                  child: const Text("If you don't have an account",
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline))),
            ],
          ),
        )
      ],
    ));
  }
}
