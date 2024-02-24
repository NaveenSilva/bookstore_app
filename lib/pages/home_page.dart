// ignore_for_file: camel_case_types

import 'package:bookstore_app/controller/book_controller.dart';
import 'package:bookstore_app/model/book_model.dart';
import 'package:bookstore_app/pages/books_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Mystery",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(BookPage());
                    },
                    child: const Text(
                      "See More",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2,
              height: 1,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: SizedBox(
                height: 220,
                child: StreamBuilder<List<BookModel>>(
                  stream: BookController().getAllBooks(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error:${snapshot.error}');
                    }
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    List<BookModel> bookItems = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bookItems.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(BookPage());
                          },
                          child: Container(
                            height: 200,
                            width: 150,
                            child: Column(
                              children: [
                                Image(
                                  image: NetworkImage(
                                    '${bookItems[index].image}',
                                  ),
                                  height: 150,
                                  width: 150,
                                ),
                                Text('${bookItems[index].title}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Horror",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(BookPage());
                      },
                      child: const Text(
                        "See More",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2,
              height: 1,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: SizedBox(
                height: 220,
                child: StreamBuilder<List<BookModel>>(
                  stream: BookController().getAllBooksHorror(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error:${snapshot.error}');
                    }
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    List<BookModel> bookItems1 = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bookItems1.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(BookPage());
                          },
                          child: Container(
                            height: 200,
                            width: 150,
                            child: Column(
                              children: [
                                Image(
                                  image: NetworkImage(
                                    '${bookItems1[index].image}',
                                  ),
                                  height: 150,
                                  width: 150,
                                ),
                                Text('${bookItems1[index].title}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Historical Novels",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(BookPage());
                      },
                      child: const Text(
                        "See More",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2,
              height: 1,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: SizedBox(
                height: 220,
                child: StreamBuilder<List<BookModel>>(
                  stream: BookController().getAllBooksHisNov(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error:${snapshot.error}');
                    }
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    List<BookModel> bookItems = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bookItems.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(BookPage());
                          },
                          child: Container(
                            height: 200,
                            width: 150,
                            child: Column(
                              children: [
                                Image(
                                  image: NetworkImage(
                                    '${bookItems[index].image}',
                                  ),
                                  height: 150,
                                  width: 150,
                                ),
                                Text('${bookItems[index].title}'),
                              ],
                            ),
                          ),
                        ),
                      ),
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
