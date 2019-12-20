import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF009688),
          leading: Icon(
            Icons.code,
            size: 38.0,
          ),
          centerTitle: true,
          titleSpacing: 5.0,
          title: Text(
            'DevClub Assignment',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontSize: 22.0),
          ),
        ),
        backgroundColor: Colors.teal[200],
        body: SafeArea(
          child: Column(),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(
            Icons.play_arrow,
            size: 30.0,
          ),
          label: Text(
            'BEGIN',
            style: TextStyle(fontSize: 20.0),
          ),
          backgroundColor: Color(0xFF03a9f4),
        ),
      ),
    );
  }
}
