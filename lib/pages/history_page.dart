import 'package:bookstore_app/controller/cart_controller.dart';
import 'package:bookstore_app/model/cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    List<String> bookTitles = [];

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "History",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 2,
                    height: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                ],
              ),
            ),
            Text("Items"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: size.height * 0.8,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 214, 214, 214),
                ),
                child: StreamBuilder<List<CartModel>>(
                  stream: cartController.getAllBills(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error:${snapshot.error}');
                    }
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    List<CartModel> cartItems = snapshot.data!;

                    bookTitles =
                        cartItems.map((item) => item.title ?? "").toList();

                    return ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        print(cartItems[index].title);
                        return Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "${cartItems[index].title}",
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "${cartItems[index].price}",
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "${cartItems[index].quantity}",
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "${cartItems[index].price! * cartItems[index].quantity!}",
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
