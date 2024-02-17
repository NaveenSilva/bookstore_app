import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uname;
  String? email;
  String? id;

  UserModel({this.uname, this.id, this.email});

  UserModel.fromMap(DocumentSnapshot data) {
    id = data.id;
    uname = data["uname"];
    email = data["email"];
  }
}
