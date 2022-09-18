// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  Color get primaryColorDark => Theme.of(this).primaryColorDark;
  Color get buttonColor => Theme.of(this).buttonColor;
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get titleStyle => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        shadows: <Shadow>[
          Shadow(
              blurRadius: 5,
              offset: Offset(1, 1),
              color: Color.fromARGB(255, 94, 0, 110))
        ],
      );
}
