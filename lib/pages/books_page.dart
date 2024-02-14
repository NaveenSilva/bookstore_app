// ignore_for_file: unused_import, avoid_unnecessary_containers

import 'package:bookstore_app/components/text_field.dart';
import 'package:flutter/material.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 60, left: 10, right: 20, bottom: 30),
          child: Row(
            children: [
              const Expanded(
                flex: 10,
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'Search',
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(onTap: () {}, child: const Icon(Icons.search)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Container(
                  width: size.width * 0.4,
                  height: size.height * 0.35,
                  color: Colors.amber,
                  child: Column(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Text("data"),
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Row(
                                  children: [
                                    Text("Title:"),
                                  ],
                                ),
                                const Row(
                                  children: [
                                    Text("Auther:"),
                                  ],
                                ),
                                const Row(
                                  children: [
                                    Text("Category:"),
                                  ],
                                ),
                                const Row(
                                  children: [
                                    Text("Published Year:"),
                                  ],
                                ),
                                const Row(
                                  children: [
                                    Text("Price:"),
                                  ],
                                ),
                                const Row(
                                  children: [
                                    Text("Quantity:"),
                                  ],
                                ),
                                const Row(
                                  children: [
                                    Text("Description:"),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.04),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    child: const Text("Add to Cart"),
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  )),
            ],
          ),
        ),
      ],
    ));
  }
}
