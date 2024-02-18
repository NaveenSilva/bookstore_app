import 'package:bookstore_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? users = FirebaseAuth.instance.currentUser;

  // late CollectionReference collectionReference2 =
  //     firebaseFirestore.collection("/users/7FYDQESzTr6fJ2lFw26w");
  late CollectionReference collectionReference1 =
      firebaseFirestore.collection("/users");

  RxList<UserModel> user = RxList<UserModel>([]);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(getAllUsers());
  }

  Stream<List<UserModel>> getAllUsers() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      return collectionReference1
          .where('id', isEqualTo: userId)
          .snapshots()
          .map((query) =>
              query.docs.map((item) => UserModel.fromMap(item)).toList());
    } else {
      return Stream.value([]);
    }
  }

  void addUser({
    required User user,
    required String uname,
    required String email,
    required String id,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uname': uname,
        'email': email,
        'id': id,
      });
    } catch (e) {
      print('Failed to upload username: $e');
    }
  }
}
