import 'package:bookstore_app/controller/book_controller.dart';
import 'package:bookstore_app/model/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  List allresults = [];
  List resultList = [];
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchController.addListener(onSearchChanged);
    getBookStream();
  }

  onSearchChanged() {
    searchResultList();
  }

  searchResultList() {
    var showResult = [];
    if (searchController.text != "") {
      for (var bookSnapShot in allresults) {
        var author = bookSnapShot['author'].toString().toLowerCase();
        var category = bookSnapShot['category'].toString().toLowerCase();
        var title = bookSnapShot['Title'].toString().toLowerCase();
        var allsearch = author + category + title;
        if (allsearch.contains(searchController.text.toLowerCase())) {
          showResult.add(bookSnapShot);
        }
      }
    } else {
      showResult = List.from(allresults);
    }
    setState(() {
      resultList = showResult;
    });
  }

  getBookStream() async {
    var data = await FirebaseFirestore.instance
        .collection("/books/category/horror")
        .orderBy('Title')
        .get();
    var data2 = await FirebaseFirestore.instance
        .collection("/books/category/historical novels")
        .orderBy('Title')
        .get();
    var data3 = await FirebaseFirestore.instance
        .collection("/books/category/mystery")
        .orderBy('Title')
        .get();

    var allDocs = [
      ...data.docs,
      ...data2.docs,
      ...data3.docs,
    ];
    setState(() {
      allresults = allDocs;
    });
    searchResultList();
  }

  @override
  void dispose() {
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getBookStream();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CupertinoSearchTextField(
          controller: searchController,
        ),
      ),
      body: ListView.builder(
        itemCount: resultList.length,
        itemBuilder: (context, index) {
          return Slidable(
            startActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                    backgroundColor: Colors.green,
                    icon: Icons.delete,
                    label: 'Add To Cart',
                    onPressed: (context) {
                      BookController().addToCart(
                        title: resultList[index]['Title'],
                        price: resultList[index]['price'],
                        // itemTotal: resultList[index]['price'] *
                        //     resultList[index]['quantity'],
                        //docId: resultList[index]['docid'].toString(),
                      );
                    })
              ],
            ),
            child: GestureDetector(
              child: Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    child: Row(
                      children: [
                        Image(
                          image: NetworkImage(
                            resultList[index]['image'],
                          ),
                          height: 150,
                          width: 150,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Title:" + resultList[index]['Title']),
                            Text("Author:" + resultList[index]['author']),
                            Text("Category:" + resultList[index]['category']),
                            Text("Year:${resultList[index]['year']}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              onTap: () {
                showBottomSheet(
                  context: context,
                  builder: (BuildContext context) => Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 168, 210, 237),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    height: size.height * 0.7,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            resultList[index]['Title'],
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Image(
                          image: NetworkImage(
                            resultList[index]['image'],
                          ),
                          width: size.width * 0.4,
                          height: size.height * 0.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: [
                              Text(
                                'Author: ${resultList[index]['author']}',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: [
                              Text(
                                'Category:${resultList[index]['category']}',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: [
                              Text(
                                'Year:${resultList[index]['year'].toString()}',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Description:${resultList[index]['Description']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
