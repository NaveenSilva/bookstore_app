import 'package:bookstore_app/pages/history_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends StatelessWidget {
  final int total;
  const PaymentPage({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            "Payment",
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                child: Column(
                  children: [
                    const Text("Payment Details"),
                    const Divider(
                      color: Colors.grey,
                      thickness: 2,
                      height: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    const Text("Card Type"),
                    const Row(
                      children: [
                        Expanded(flex: 1, child: Text("card1")),
                        Expanded(flex: 1, child: Text("card2")),
                      ],
                    ),
                    const Text("Card Number"),
                    const Text("Card Field"),
                    const Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text("Expiration Month:"),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(" Month:"),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text("Expiration Year:"),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(" Year"),
                        ),
                      ],
                    ),
                    const Text("CVN:"),
                    const Text("CVN Number"),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const Text("Your Order"),
                const Divider(
                  color: Colors.grey,
                  thickness: 2,
                  height: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.amber,
                        child: const Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Total Amount:",
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Total amount",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Cancel",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.off(const HistoryPage());
                              },
                              child: Text(
                                "Pay",
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
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
