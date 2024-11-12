import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 메인페이지
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Text('Hello, groomingo!'));
  }
}
