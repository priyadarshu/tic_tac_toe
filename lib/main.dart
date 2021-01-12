import 'package:flutter/material.dart';
import 'package:tic_tac_toe/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TicTacToe Game App',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: new HomePage(),
    );
  }
}
