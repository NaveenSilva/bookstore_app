// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class CartController extends GetxController {
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   late CollectionReference collectionReference =
//       firebaseFirestore.collection("");
  
//   @override
//   void onInit() {
//     super.onInit();
//   }

//   void addToCart(
//       {required String docId, required String title, required int price}) {
//     collectionReference.add({'Title': title, 'price': price, 'quantity': 1});
//   }
// }
