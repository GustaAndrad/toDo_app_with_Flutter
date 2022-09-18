import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListUiConfig {
  TodoListUiConfig._();

  static ThemeData get theme => ThemeData(
        textTheme: GoogleFonts.mandaliTextTheme(),
        scaffoldBackgroundColor: const Color(0xff1E1456),
        primaryColor: const Color(0xff5C77CE),
        primaryColorLight: const Color(0xffABC8F7),
        primaryColorDark: const Color(0xffABC8F7),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 143, 55, 165),
          ),
        ),
      );
}
