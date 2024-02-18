// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:bookstore_app/controller/user_controller.dart';
import 'package:bookstore_app/model/user_model.dart';
import 'package:bookstore_app/pages/logIn_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;
    return Container(
      //color: Colors.amber,
      //width: size.width,
      //height: double.infinity,
      child: ListView(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Icon(Icons.account_circle_outlined,
                        size: size.width * 0.25),
                  ),
                  const Text("Profile", style: TextStyle(fontSize: 25)),
                  StreamBuilder<List<UserModel>>(
                    stream: UserController().getAllUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error:${snapshot.error}');
                      }
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      List<UserModel> users = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: users.length,
                        itemBuilder: (context, index) => Expanded(
                          flex: 3,
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          "User Name",
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          '${users[index].uname}',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          "Email",
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          "${users[index].email}",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              FirebaseAuth.instance.signOut();
                                              Get.off(LogInPage());
                                            },
                                            child: const Text("Log Out")),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            child: Text("Update")),
                                      ),
                                    ),
                                    SizedBox(height: 25),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
