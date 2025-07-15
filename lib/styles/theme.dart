import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.grey[200],
  appBarTheme: AppBarTheme(color: Colors.grey[200]),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.purple,
    brightness: Brightness.light,
    surface: Colors.white,
    surfaceContainer: Colors.grey[300]!,
    onSurface: Colors.black,
    secondary: Colors.purple, //화살표
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xFF1B1B1B),
  appBarTheme: AppBarTheme(color: Color(0xFF1B1B1B)),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.purple,
    brightness: Brightness.dark,
    surface: Colors.grey[800],
    surfaceContainer: Colors.grey[700]!,
    onSurface: Colors.white,
    secondary: Colors.white, // 화살표
  ),
);
