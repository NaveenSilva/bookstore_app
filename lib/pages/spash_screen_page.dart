import 'package:bookstore_app/pages/logInPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({super.key});

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Get.off(const logInPage(), transition: Transition.leftToRight);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.book_rounded, size: 50),
          Text("Book Store",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ],
      ),
    ));
  }
}
