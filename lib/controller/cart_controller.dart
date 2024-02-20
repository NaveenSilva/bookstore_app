import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? users = FirebaseAuth.instance.currentUser;

  // late CollectionReference collectionReference4 =
  //     firebaseFirestore.collection("/cart/bZWB6s1ZzOGNokT9kuuI/a1");
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  RxBool isLoading = true.obs;

  Future<void> transferData() async {
    try {
      isLoading.value = true;
      QuerySnapshot<Map<String, dynamic>> cartSnapshot = await firebaseFirestore
          .collection('/cart/bZWB6s1ZzOGNokT9kuuI/a1')
          .get();

      List<Map<String, dynamic>> cartData = [];
      for (var doc in cartSnapshot.docs) {
        Map<String, dynamic> data = {
          'Title': doc['Title'],
          'price': doc['price'],
          'quantity': doc['quantity']
        };
        cartData.add(data);
      }

      cartData.forEach((data) async {
        await firebaseFirestore
            .collection('/order history/0oUrzD3W0t2tXPcvJ51o/a')
            .add(data);
      });

      isLoading.value = false;
      print('Data transfer completed successfully.');
    } catch (error) {
      isLoading.value = false;
      print('Error transferring data: $error');
    }
  }
}
