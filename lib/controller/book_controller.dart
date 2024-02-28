import 'package:bookstore_app/model/book_model.dart';
import 'package:bookstore_app/model/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BookController extends GetxController {
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference =
      firebaseFirestore.collection("/cart/bZWB6s1ZzOGNokT9kuuI/$userId");
  late CollectionReference collectionReference1 =
      firebaseFirestore.collection("/books/category/mystery");
  late CollectionReference collectionReference2 =
      firebaseFirestore.collection("/books/category/horror");
  late CollectionReference collectionReference3 =
      firebaseFirestore.collection("/books/category/historical novels");

  int y = 0;
  RxInt cartTotal = 0.obs;

  RxList<CartModel> cart = RxList<CartModel>([]);
  RxList<BookModel> book = RxList<BookModel>([]);

  List<BookModel> cartItem = [];

  @override
  void onInit() {
    super.onInit();
    cart.bindStream(getAllItems());
    book.bindStream(getAllBooks());
  }

  void addToCart({String? docId, required String title, required int price}) {
    collectionReference.add({'Title': title, 'price': price, 'quantity': 1});
    //print(userId);
    // cartTotal.value += price;
    updateCartTotal();
    update();
    // print(cartTotal);
  }

  Stream<List<CartModel>> getAllItems() => collectionReference.snapshots().map(
      (query) => query.docs.map((item) => CartModel.fromMap(item)).toList());

  Stream<List<BookModel>> getAllBooks() => collectionReference1.snapshots().map(
      (query) => query.docs.map((item) => BookModel.fromMap(item)).toList());

  Stream<List<BookModel>> getAllBooksHorror() =>
      collectionReference2.snapshots().map((query) =>
          query.docs.map((item) => BookModel.fromMap(item)).toList());

  Stream<List<BookModel>> getAllBooksHisNov() =>
      collectionReference3.snapshots().map((query) =>
          query.docs.map((item) => BookModel.fromMap(item)).toList());

  updateQuantity(String docId, int quantity) {
    collectionReference.doc(docId).update({'quantity': quantity});
  }

  void incrementQuantity(String docId) {
    if (cart.isNotEmpty) {
      int currentQuantity =
          cart.firstWhere((item) => item.docId == docId).quantity ?? 0;

      currentQuantity++;
      updateQuantity(docId, currentQuantity);
       updateCartTotal();
      update();
    }
  }

  void decrementQuantity(String docId) {
    if (cart.isNotEmpty) {
      int currentQuantity =
          cart.firstWhere((item) => item.docId == docId).quantity ?? 0;
      if (currentQuantity > 1) {
        currentQuantity--;
        updateQuantity(docId, currentQuantity);
        updateCartTotal();
        update();
      }
    }
  }
  void updateCartTotal() {
  cartTotal.value = cart.fold(0, (sum, item) => sum + (item.quantity! * item.price!));
}
void updateCartTotal1(List<CartModel> cartItems) {
  cartTotal.value = cartItems.fold(0, (sum, item) => sum + (item.quantity! * item.price!));
}

  DismissedItem(String docId) {
    collectionReference.doc(docId).delete();
    updateCartTotal();
  }
}
