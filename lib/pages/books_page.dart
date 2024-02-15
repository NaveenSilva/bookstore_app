import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final firestoreInstance = FirebaseFirestore.instance;
  List<Module> books = [];
  bool isLoading = true;

  @override
  void initState() {
    fetchModulesData();
    super.initState();
  }

  Future<void> fetchModulesData() async {
    try {
      final bookCollection = await firestoreInstance
          .collection("books")
          .doc("category")
          .collection("mystery")
          .get();

      List<Module> booksItem = bookCollection.docs.map((doc) {
        return Module(
          title: doc.get("Title"),
          author: doc.get("author"),
          category: doc.get("category"),
          description: doc.get("Description"),
          price: doc.get("price"),
          year: doc.get("year"),
        );
      }).toList();

      books.addAll(booksItem);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching modules data!');
    }
  }

  Future<void> _refreshData() async {
    await fetchModulesData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 20, right: 20, bottom: 30),
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
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: books.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return isLoading
                    ? const Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : books.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.only(top: 100),
                            child: Center(
                              child: Text("No Data available"),
                            ),
                          )
                        : Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 10),
                                child: Container(
                                  width: size.width * 0.65,
                                  height: size.height * 0.365,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 216, 215, 215),
                                  ),
                                  child: Column(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text("Image"),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Title: ${books[index].title}',
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Author: ${books[index].author}',
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Published Year: ${books[index].year.toString()}',
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                'Description: ${books[index].description}',
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'price : ${books[index].price.toString()}',
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: size.height * 0.04),
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  style: ButtonStyle(
                                                    shape:
                                                        MaterialStatePropertyAll(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                  child:
                                                      const Text("Add to Cart"),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Module {
  final String title;
  final String author;
  final String category;
  final String description;
  final int year;
  final int price;

  Module({
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    required this.year,
    required this.price,
  });
}
