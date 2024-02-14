// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class home_page extends StatelessWidget {
  const home_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, left: 10),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Mystery",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {},
                        child: const Text("See More",
                            style: TextStyle(color: Colors.blue)))),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2,
              height: 1,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(height: 200, width: 150, color: Colors.amber),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Container(height: 200, width: 150, color: Colors.red),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Container(height: 200, width: 150, color: Colors.amber),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Container(height: 200, width: 150, color: Colors.amber),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Science Fiction",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {},
                          child: const Text("See More",
                              style: TextStyle(color: Colors.blue)))),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2,
              height: 1,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(height: 200, width: 150, color: Colors.amber),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Container(height: 200, width: 150, color: Colors.red),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Container(height: 200, width: 150, color: Colors.amber),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Container(height: 200, width: 150, color: Colors.amber),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Horror",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {},
                          child: const Text("See More",
                              style: TextStyle(color: Colors.blue)))),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2,
              height: 1,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(height: 200, width: 150, color: Colors.amber),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Container(height: 200, width: 150, color: Colors.red),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Container(height: 200, width: 150, color: Colors.amber),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Container(height: 200, width: 150, color: Colors.amber),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
