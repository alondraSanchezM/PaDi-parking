import 'package:flutter/material.dart';
import 'src/firstTime.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PaDi',
      home: FirstTime(),
    );
  }
}