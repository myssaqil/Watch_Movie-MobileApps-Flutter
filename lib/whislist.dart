import 'package:flutter/material.dart';

class Whislist extends StatefulWidget {
  const Whislist({Key? key}) : super(key: key);

  @override
  State<Whislist> createState() => _SearchState();
}

class _SearchState extends State<Whislist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              )),
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Whislist",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
