import 'package:flutter/material.dart';
import 'package:flutter_train_app/pages/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MateriaApp은 Google의 Material Design 가이드라인을 따르는 앱을 만들 때 사용하는 기본 위젯!
    return MaterialApp(
      title: '기차 예매 서비스',
      // theme: ThemeData(primarySwatch: Colors.amber),
      home: HomePage(),
    );
  }
}
