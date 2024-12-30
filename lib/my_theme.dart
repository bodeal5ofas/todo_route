import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLight = const Color(0xFF5D9CEC);
  static Color backgroundLight = const Color(0xffdfecdb);
  static Color backgroundDark = const Color(0xff060e1e);
  static Color greenLight = const Color(0xff61e757);
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;
  static Color redColor = Colors.red;
  static Color greyColor = Colors.grey;
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryLight,
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: AppBarTheme(color: primaryLight),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.blue,
      unselectedItemColor: blackColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryLight, foregroundColor: whiteColor),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: whiteColor,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
      titleSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: primaryLight,
      ),
    ),
  );
static ThemeData darkTheme = ThemeData(
    primaryColor: primaryLight,
    scaffoldBackgroundColor: backgroundDark,
    appBarTheme: AppBarTheme(color: primaryLight),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.blue,
      unselectedItemColor: blackColor,
    ),
    bottomSheetTheme:const BottomSheetThemeData(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryLight, foregroundColor: whiteColor),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: whiteColor
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
      titleSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: primaryLight,
      ),
    ),
  );

}
