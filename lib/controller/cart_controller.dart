import 'package:bookstore_app/controller/book_controller.dart';
import 'package:bookstore_app/model/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? users = FirebaseAuth.instance.currentUser;
  final bookController = Get.put(BookController());
  Map<String, dynamic> allItems = {};
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  //---------------------------------------------------------------------------------------------------

  RxList<CartModel> cart = RxList<CartModel>([]);

@override
  void onInit() {
    cart.bindStream(getAllBills());
    getAllBills().listen((items) {});
    super.onInit();
  }
  late CollectionReference collectionReference4 =
      firebaseFirestore.collection("/cart/bZWB6s1ZzOGNokT9kuuI/$userId");

  Future<void> createDataInFirebase(
      int length, List bookTitles, List bookPrices, List bookQuantities) async {
    try {
      int billTotal = 0;
      for (int x = 0; x < length; x++) {
        allItems['item$x'] = {
          'item$x': {
            'Title': bookTitles[x],
            'price': int.parse(bookPrices[x]),
            'quantity': int.parse(bookQuantities[x]),
          },
        };
       // billTotal = bookController.cartTotal;
      }

      DocumentReference newDocRef = await FirebaseFirestore.instance
          .collection('/order history/0oUrzD3W0t2tXPcvJ51o/$userId')
          .add(allItems);
      await newDocRef.update({
        'total': billTotal,
        'id': userId,
      });

      print('Data created successfully in Firestore.11111');
    } catch (error) {
      print('Error creating data in Firestore: $error');
    }
  }

    Stream<List<CartModel>> getAllBills() => collectionReference4.snapshots().map(
      (query) => query.docs.map((item) => CartModel.fromMap(item)).toList());
}
