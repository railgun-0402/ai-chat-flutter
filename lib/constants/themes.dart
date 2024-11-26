import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  colorScheme: ThemeData.light().colorScheme.copyWith(
    // 基本は白
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: const Color(0xFF4A5568),
    onSecondary: Colors.white,
  ),
);

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: ThemeData.dark().colorScheme.copyWith(
    primary: Colors.black,
    onPrimary: Colors.white,
    secondary: const Color(0xFF4A5568),
    onSecondary: Colors.white,
  ),
);