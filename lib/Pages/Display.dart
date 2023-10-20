import 'package:flutter/material.dart';

class DisplayNum extends StatefulWidget {
  const DisplayNum({Key? key}) : super(key: key);

  @override
  State<DisplayNum> createState() => _DisplayNumState();
}

class _DisplayNumState extends State<DisplayNum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Number Diplaying"),
      ),
      body: Center(
        child: Text(
          "This is display page"
        ),
      ),

    );
  }
}
