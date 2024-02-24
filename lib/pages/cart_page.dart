import 'package:bookstore_app/controller/book_controller.dart';
import 'package:bookstore_app/controller/cart_controller.dart';
import 'package:bookstore_app/model/book_model.dart';
import 'package:bookstore_app/model/cart_model.dart';
import 'package:bookstore_app/pages/payment_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final bookController = Get.put(BookController());
  final cartController = Get.put(CartController());
  int len = 0;
  var docID;
  String? title;
  int? price;
  int? quantity;
  int total = 0;
  int currantQ = 0;
  List<String> bookTitles = [];
  List<String> bookPrices = [];
  List<String> bookQuantities = [];
  Map<String, dynamic> allItems = {};
  Map<String, dynamic> newData = {};
  Map<String, Object> $i = {};
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
              stream: bookController.getAllItems(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error:${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                List<CartModel> cartItems = snapshot.data!;
                // BookController().calculateTotal(cartItems[index].price);

                ///////////////////////////////////////////////////////////////////////////////////

                return ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      bookController.y =
                          cartItems[index].quantity! * cartItems[index].price!;
                      bookController.cartTotal =
                          bookController.cartTotal + bookController.y;

                      docID = cartItems[index].docId;
                      title = cartItems[index].title;
                      price = cartItems[index].price;
                      quantity = cartItems[index].quantity;

                      bookTitles.add('${cartItems[index].title}');
                      bookPrices.add('${cartItems[index].price}');
                      bookQuantities.add('${cartItems[index].quantity}');

                      print(bookTitles[0]);
//////////////////////////////////////////////////////////////////
                      // Future<void> addDataToFirebaseField1() async {
                      //   try {
                      //     final DocumentReference<Map<String, dynamic>> docRef =
                      //         FirebaseFirestore.instance
                      //             .collection('/cart/bZWB6s1ZzOGNokT9kuuI/a1')
                      //             .doc('${docID}');

                      //     Map<String, dynamic> newData = {
                      //       '123123': {
                      //         'Title': '${title}',
                      //         'price': '${price}',
                      //         'quantity': '${quantity}',
                      //       },
                      //       'total': bookController.cartTotal,
                      //     };
                      //     await docRef.update({
                      //       'your_field_name': newData,
                      //     });

                      //     await FirebaseFirestore.instance
                      //         .collection(
                      //             '/order history/0oUrzD3W0t2tXPcvJ51o/${userId}')
                      //         .doc("1232")
                      //         .set(newData);
                      //     print('Data added to the field successfully.');
                      //   } catch (error) {
                      //     print('Error adding data to the field: $error');
                      //   }
                      // }

                      print(bookController.cartTotal);
                      //print(index);
                      //print(cartItems[index].docId);
                      len = cartItems.length;
                      return Slidable(
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
                                                  icon: const Icon(Icons
                                                      .remove_circle_rounded),
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

                                                    bookController.cartTotal =
                                                        0;
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
                      );
                    });
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
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      bookController.cartTotal.toString(),
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(
                          () {
                            bookController.cartTotal.toString();
                          },
                        );
                        cartController.createDataInFirebase(
                            len, bookTitles, bookPrices, bookQuantities);
                        //Get.to(PaymentPage(total: cartTotal));
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
