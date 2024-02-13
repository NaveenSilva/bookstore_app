import 'package:bookstore_app/pages/ProfilePage.dart';
import 'package:bookstore_app/pages/books_page.dart';
import 'package:bookstore_app/pages/cart_page.dart';
import 'package:bookstore_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedItem = 0;
  final tab = [
    home_page(),
    BooksPage(),
    CartPage(),
    ProfilePage(),
    Center(
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
