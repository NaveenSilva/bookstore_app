import 'package:bookstore_app/model/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BookController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference =
      firebaseFirestore.collection("/cart/bZWB6s1ZzOGNokT9kuuI/a1");

  RxList<CartModel> cart = RxList<CartModel>([]);
  @override
  void onInit() {
    super.onInit();

    cart.bindStream(getAllItems());
  }

  void addToCart(
      {required String docId, required String title, required int price}) {
    collectionReference.add({'Title': title, 'price': price, 'quantity': 1});
  }

  Stream<List<CartModel>> getAllItems() => collectionReference.snapshots().map(
      (query) => query.docs.map((item) => CartModel.fromMap(item)).toList());
}
