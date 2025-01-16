import 'package:flutter/material.dart';
import 'package:first_app/gradient_container.dart';

void main() {
  //  const List<Color> colors = [
  //   Color.fromARGB(255, 90, 2, 80),
  //   Color.fromARGB(255, 255, 7, 98),
  // ];
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Center(child: Text("Flutter First App"))),
        body: GradientContainer.purple(),
      ),
    ),
  );
}
