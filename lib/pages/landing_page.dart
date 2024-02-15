// ignore_for_file: unused_import, unused_local_variable, file_names, prefer_const_constructors_in_immutables

import 'package:bookstore_app/pages/home_page.dart';
import 'package:bookstore_app/pages/profile_page.dart';
import 'package:bookstore_app/pages/books_page.dart';
import 'package:bookstore_app/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatefulWidget {
  LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int selectedItem = 0;
  final tab = [
    const HomePage(),
    const BookPage(),
    const CartPage(),
    const ProfilePage(),
    const Center(
      child: Text("asd"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: tab[selectedItem],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: '')
        ],
        currentIndex: selectedItem,
        selectedItemColor: Colors.blue,
        onTap: (int index) {
          setState(() {
            selectedItem = index;
          });
        },
      ),
    );
  }
}
