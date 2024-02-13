import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.amber,
      //width: size.width,
      //height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                    Text("Profile", style: TextStyle(fontSize: 25)),
                  ],
                ),
              )),
          Expanded(flex: 3, child: Text("data"))
        ],
      ),
    );
  }
}
