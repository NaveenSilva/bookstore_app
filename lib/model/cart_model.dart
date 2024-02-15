import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  String? docId;
  String? title;
  int? price;
  int? quantity;
  //int? total;

  CartModel({
    this.docId,
    this.title,
    this.price,
    this.quantity,
  });

  CartModel.fromMap(DocumentSnapshot data) {
    docId = data.id;
    title = data["Title"];
    price = data["price"];
    quantity = data["quantity"];
  }
}
