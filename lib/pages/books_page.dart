import 'package:bookstore_app/controller/book_controller.dart';
import 'package:bookstore_app/model/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
    print(searchController.text);
    searchResultList();
  }

  searchResultList() {
    var showResult = [];
    if (searchController.text != "") {
      for (var bookSnapShot in allresults) {
        var title = bookSnapShot['Title'].toString().toLowerCase();
        if (title.contains(searchController.text.toLowerCase())) {
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
    var allDocs = [...data.docs, ...data2.docs, ...data3.docs];
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
            startActionPane: ActionPane(motion: StretchMotion(), children: [
              SlidableAction(
                backgroundColor: Colors.green,
                icon: Icons.delete,
                label: 'Add To Cart',
                onPressed: (context) => BookController().addToCart(
                  title: resultList[index]['Title'],
                  price: resultList[index]['price'],
                  //docId: resultList[index]['docid'].toString(),
                ),
              )
            ]),
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
                          Text("Year:" + resultList[index]['year'].toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    //     Padding(
    //   padding: const EdgeInsets.only(top: 20, left: 10),
    //   child: ListView(
    //     children: [
    //       Padding(
    //         padding:
    //             const EdgeInsets.only(left: 10, top: 20, right: 20, bottom: 30),
    //         child: Row(
    //           children: [
    //             const Expanded(
    //               flex: 10,
    //               child: TextField(
    //                 obscureText: false,
    //                 decoration: InputDecoration(
    //                   enabledBorder: OutlineInputBorder(
    //                     borderSide: BorderSide(color: Colors.black),
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                   ),
    //                   focusedBorder: OutlineInputBorder(
    //                     borderSide: BorderSide(color: Colors.blue),
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                   ),
    //                   hintText: 'Search',
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(
    //               width: 10,
    //             ),
    //             GestureDetector(
    //               onTap: () {},
    //               child: const Icon(Icons.search),
    //             ),
    //           ],
    //         ),
    //       ),
    //       StreamBuilder<List<BookModel>>(
    //         stream: BookController().getAllBooks(),
    //         builder: (context, snapshot) {
    //           if (snapshot.hasError) {
    //             return Text('Error:${snapshot.error}');
    //           }
    //           if (!snapshot.hasData) {
    //             return const CircularProgressIndicator();
    //           }
    //           List<BookModel> bookItems = snapshot.data!;

    //           return ListView.builder(
    //               shrinkWrap: true,
    //               physics: NeverScrollableScrollPhysics(),
    //               scrollDirection: Axis.vertical,
    //               itemCount: bookItems.length,
    //               itemBuilder: (context, index) => Slidable(
    //                     startActionPane:
    //                         ActionPane(motion: StretchMotion(), children: [
    //                       SlidableAction(
    //                         backgroundColor: Colors.green,
    //                         icon: Icons.delete,
    //                         label: 'Add To Cart',
    //                         onPressed: (context) => BookController().addToCart(
    //                             title: '${bookItems[index].title}',
    //                             price: bookItems[index].price!,
    //                             docId: '${bookItems[index].id}'),
    //                       ),
    //                     ]),
    //                     child: Container(
    //                       height: 200,
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: Container(
    //                           height: 50,
    //                           child: Row(
    //                             children: [
    //                               Image(
    //                                 image: NetworkImage(
    //                                   '${bookItems[index].image}',
    //                                 ),
    //                                 height: 150,
    //                                 width: 150,
    //                               ),
    //                               Column(
    //                                 mainAxisAlignment: MainAxisAlignment.center,
    //                                 children: [
    //                                   Text('Title:${bookItems[index].title}'),
    //                                   Text('Author:${bookItems[index].author}'),
    //                                   Text(
    //                                       'Category:${bookItems[index].category}'),
    //                                   Text('Year:${bookItems[index].year}'),
    //                                 ],
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ));
    //         },
    //       ),
    //       StreamBuilder<List<BookModel>>(
    //         stream: BookController().getAllBooksHorror(),
    //         builder: (context, snapshot) {
    //           if (snapshot.hasError) {
    //             return Text('Error:${snapshot.error}');
    //           }
    //           if (!snapshot.hasData) {
    //             return const CircularProgressIndicator();
    //           }
    //           List<BookModel> bookItems1 = snapshot.data!;
    //           return ListView.builder(
    //             shrinkWrap: true,
    //             physics: NeverScrollableScrollPhysics(),
    //             scrollDirection: Axis.vertical,
    //             itemCount: bookItems1.length,
    //             itemBuilder: (context, index) => Slidable(
    //               startActionPane:
    //                   ActionPane(motion: StretchMotion(), children: [
    //                 SlidableAction(
    //                   backgroundColor: Colors.green,
    //                   icon: Icons.delete,
    //                   label: 'Add To Cart',
    //                   onPressed: (context) => BookController().addToCart(
    //                       title: '${bookItems1[index].title}',
    //                       price: bookItems1[index].price!,
    //                       docId: '${bookItems1[index].id}'),
    //                 ),
    //               ]),
    //               child: Container(
    //                 height: 200,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Container(
    //                     height: 50,
    //                     child: Row(
    //                       children: [
    //                         Image(
    //                           image: NetworkImage(
    //                             '${bookItems1[index].image}',
    //                           ),
    //                           height: 150,
    //                           width: 150,
    //                         ),
    //                         Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Text('Title:${bookItems1[index].title}'),
    //                             Text('Author:${bookItems1[index].author}'),
    //                             Text('Category:${bookItems1[index].category}'),
    //                             Text('Year:${bookItems1[index].year}'),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           );
    //         },
    //       ),
    //       StreamBuilder<List<BookModel>>(
    //         stream: BookController().getAllBooksHisNov(),
    //         builder: (context, snapshot) {
    //           if (snapshot.hasError) {
    //             return Text('Error:${snapshot.error}');
    //           }
    //           if (!snapshot.hasData) {
    //             return const CircularProgressIndicator();
    //           }
    //           List<BookModel> bookItems2 = snapshot.data!;
    //           return ListView.builder(
    //             shrinkWrap: true,
    //             physics: NeverScrollableScrollPhysics(),
    //             scrollDirection: Axis.vertical,
    //             itemCount: bookItems2.length,
    //             itemBuilder: (context, index) => Slidable(
    //               startActionPane:
    //                   ActionPane(motion: StretchMotion(), children: [
    //                 SlidableAction(
    //                   backgroundColor: Colors.green,
    //                   icon: Icons.delete,
    //                   label: 'Add To Cart',
    //                   onPressed: (context) => BookController().addToCart(
    //                       title: '${bookItems2[index].title}',
    //                       price: bookItems2[index].price!,
    //                       docId: '${bookItems2[index].id}'),
    //                 ),
    //               ]),
    //               child: Container(
    //                 height: 200,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Row(
    //                     children: [
    //                       Image(
    //                         image: NetworkImage(
    //                           '${bookItems2[index].image}',
    //                         ),
    //                         height: 150,
    //                         width: 150,
    //                       ),
    //                       Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           Text('Title:${bookItems2[index].title}'),
    //                           Text('Author:${bookItems2[index].author}'),
    //                           Text('Category:${bookItems2[index].category}'),
    //                           Text('Year:${bookItems2[index].year}'),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    // ));
  }
}
