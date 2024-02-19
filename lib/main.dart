// ignore_for_file: unused_import

import 'package:bookstore_app/pages/home_page.dart';
import 'package:bookstore_app/pages/landing_page.dart';
import 'package:bookstore_app/pages/books_page.dart';
import 'package:bookstore_app/pages/signin_page.dart';
import 'package:bookstore_app/pages/profile_page.dart';
import 'package:bookstore_app/pages/cart_page.dart';
import 'package:bookstore_app/pages/logIn_page.dart';
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
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: LogInPage(),
    );
  }
}
