import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListUiConfig {
  TodoListUiConfig._();

  static ThemeData get theme => ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.mandaliTextTheme(),
        scaffoldBackgroundColor: const Color(0xff1E1456),
        primaryColor: Color.fromARGB(255, 8, 0, 56),
        primaryColorLight: Color.fromARGB(255, 143, 55, 165),
        primaryColorDark: const Color(0xffABC8F7),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 143, 55, 165),
          ),
        ),
      );
}
