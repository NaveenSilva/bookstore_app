import 'package:bookstore_app/controller/book_controller.dart';
import 'package:bookstore_app/controller/cart_controller.dart';
import 'package:bookstore_app/model/cart_model.dart';
import 'package:bookstore_app/pages/payment_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //int total = 0;
  @override
  Widget build(BuildContext context) {

    final bookController = Get.put(BookController());
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
              stream: bookController.getAllItems(),
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
                  itemBuilder: (context, index) => Slidable(
                    endActionPane:
                        ActionPane(motion: BehindMotion(), children: [
                      SlidableAction(
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: 'Delete',
                        onPressed: (context) => BookController()
                            .DismissedItem('${cartItems[index].docId}'),
                      ),
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: size.height * 0.15,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 214, 214, 214),
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
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: IconButton(
                                              icon: const Icon(
                                                  Icons.remove_circle_rounded),
                                              onPressed: () {
                                                bookController
                                                    .decrementQuantity(
                                                  '${cartItems[index].docId}',
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text(
                                              '${cartItems[index].quantity}',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: IconButton(
                                              icon: const Icon(
                                                  Icons.add_circle_rounded),
                                              onPressed: () {
                                                bookController
                                                    .incrementQuantity(
                                                  '${cartItems[index].docId}',
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        '${cartItems[index].price}',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${cartItems[index].quantity! * cartItems[index].price!}',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Text("(Swap Left to Remove Item)"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 170, 184, 193).withOpacity(0.4),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Total:",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(PaymentPage(total: 2500));
                      },
                      child: const Text(
                        "Buy",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
