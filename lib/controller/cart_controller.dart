import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference4 =
      firebaseFirestore.collection("/books/category/historical novels");

  // void addToCart({String? docId, required total, required String,required int price}) {
  // collectionReference4.add({'Title': title, 'price': price, 'quantity': 1});}
  
}
