import 'package:bookstore_app/controller/book_controller.dart';
import 'package:bookstore_app/controller/cart_controller.dart';
import 'package:bookstore_app/model/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int counter = 1;

  void increment() {
    setState(() {
      counter++;
    });
  }

  void decrement() {
    setState(() {
      counter--;
      if (counter < 1) {
        counter = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60),
            child: Center(
              child: Text(
                "My Cart",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Expanded(
            child: StreamBuilder<List<CartModel>>(
              stream: BookController().getAllItems(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error:${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                List<CartModel> cartItems = snapshot.data!;
                return ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 214, 214, 214),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    cartItems[index].title.toString(),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove_circle_rounded),
                                        onPressed: () {
                                          decrement();
                                        },
                                      ),
                                      Text(
                                        '$counter',
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add_circle_rounded),
                                        onPressed: () {
                                          increment();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 50),
                                    child: Text("Price"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                              flex: 1,
                              child: Text("(Swap Left to Remove Item)")),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
