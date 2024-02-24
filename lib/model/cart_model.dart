import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  String? docId;
  String? title;
  int? price;
  int? quantity;

  CartModel({
    required this.docId,
    required this.title,
    required this.price,
    required this.quantity,
  });

  CartModel.fromMap(DocumentSnapshot data) {
    docId = data.id;
    title = data["Title"];
    price = data["price"];
    quantity = data["quantity"];
  }
}
