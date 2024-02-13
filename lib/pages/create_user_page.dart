import 'package:bookstore_app/components/text_field.dart';
import 'package:bookstore_app/pages/logInPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class create_user_page extends StatelessWidget {
  const create_user_page({super.key});

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
            SizedBox(
              height: 15,
            ),
            myTextField(hint: "Email"),
            myTextField(hint: "Password"),
            myTextField(hint: "Conform Password"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {},
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
}
