// ignore_for_file: unused_import

import 'package:bookstore_app/pages/HomePage.dart';
import 'package:bookstore_app/pages/create_user_page.dart';
import 'package:bookstore_app/pages/profile_page.dart';
import 'package:bookstore_app/pages/books_page.dart';
import 'package:bookstore_app/pages/cart_page.dart';
import 'package:bookstore_app/pages/logInPage.dart';
import 'package:bookstore_app/pages/spash_screen_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bookstore_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SpashScreen(),
    );
  }
}
