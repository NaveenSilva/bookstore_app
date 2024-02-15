// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:bookstore_app/pages/logIn_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.amber,
      //width: size.width,
      //height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Icon(Icons.account_circle_outlined,
                          size: size.width * 0.25),
                    ),
                    const Text("Profile", style: TextStyle(fontSize: 25)),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                  child: Column(
                children: [
                  Text("data"),
                  SizedBox(height: 25),
                  Text("data2"),
                  SizedBox(height: 25),
                  Text("data3"),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Get.off(LogInPage());
                          },
                          child: const Text("Log Out")),
                    ],
                  )
                ],
              )))
        ],
      ),
    );
  }
}
