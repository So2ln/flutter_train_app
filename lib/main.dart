import 'package:flutter/material.dart';
import 'package:flutter_train_app/pages/home_page.dart';
import 'package:flutter_train_app/styles/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MateriaApp은 Google의 Material Design 가이드라인을 따르는 앱을 만들 때 사용하는 기본 위젯!
    return MaterialApp(
      title: '기차 예매',
      debugShowCheckedModeBanner: false,

      // 앱의 테마 설정
      themeMode: ThemeMode.dark, // 시스템 테마를 따름
      theme: lightTheme,
      darkTheme: darkTheme,
      home: HomePage(),
    );
  }
}
