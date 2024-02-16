import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  String? title;
  String? image;
  String? author;
  String? description;
  String? category;
  String? id;
  int? price;
  int? year;

  BookModel(
      {this.title,
      this.image,
      this.author,
      this.description,
      this.category,
      this.id,
      this.price,
      this.year});

  BookModel.fromMap(DocumentSnapshot data) {
    title = data["Title"];
    image = data["image"];
    author = data["author"];
    description = data["Description"];
    category = data["category"];
    price = data["price"];
    year = data["year"];
    id = data["id"];
  }
}
