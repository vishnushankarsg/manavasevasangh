import 'package:flutter/material.dart';

class AppTheme {
  //
  AppTheme._();
  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey[200],
      primaryColor: Colors.grey[200],
      dividerColor: Colors.grey[800],
      appBarTheme: AppBarTheme(
          color: Colors.grey[200],
          iconTheme: IconThemeData(
            color: Colors.black54,
            size: 26.0,
          ),
          titleTextStyle: TextStyle(color: Colors.black54, fontSize: 22.0),
          elevation: 5.0),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[700],
        unselectedIconTheme: IconThemeData(
          color: Colors.white60,
          size: 26.0,
        ),
        selectedLabelStyle: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle:
            TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500),
        selectedIconTheme: IconThemeData(color: Colors.grey[500], size: 26.0),
      ),
      cardTheme: CardTheme(
        color: Colors.grey[200],
        elevation: 5.0,
      ),
      iconTheme: IconThemeData(
        color: Colors.black54,
        size: 30.0,
      ),
      textTheme: TextTheme(
          headline1: TextStyle(
              color: Colors.black54, fontSize: 26, fontWeight: FontWeight.w600),
          headline2: TextStyle(
              color: Colors.black45, fontSize: 24, fontWeight: FontWeight.w400),
          headline3: TextStyle(
              color: Colors.black54, fontSize: 24, fontWeight: FontWeight.w400),
          bodyText1: TextStyle(color: Colors.orange[600], fontSize: 22),
          bodyText2: TextStyle(color: Colors.black54, fontSize: 18)),
      hintColor: Colors.black38,
      colorScheme: ColorScheme.light(
          primary: Colors.black54,
          secondary: Colors.white,
          onPrimary: Colors.orange[600]));

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[800],
    primaryColor: Colors.grey[800],
    dividerColor: Colors.grey[200],
    appBarTheme: AppBarTheme(
        color: Colors.grey[800],
        iconTheme: IconThemeData(
          color: Colors.white60,
          size: 26.0,
        ),
        titleTextStyle: TextStyle(color: Colors.white60, fontSize: 22.0),
        elevation: 5.0),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[700],
      unselectedIconTheme: IconThemeData(
        color: Colors.grey[200],
        size: 26.0,
      ),
      selectedLabelStyle: TextStyle(
        color: Colors.amber,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle:
          TextStyle(color: Colors.grey[200], fontWeight: FontWeight.w500),
      selectedIconTheme: IconThemeData(color: Colors.amber, size: 26.0),
    ),
    cardTheme: CardTheme(
      color: Colors.grey[800],
      elevation: 5.0,
    ),
    iconTheme: IconThemeData(
      color: Colors.white60,
      size: 30.0,
    ),
    textTheme: TextTheme(
        headline1: TextStyle(
            color: Colors.white60, fontSize: 26, fontWeight: FontWeight.w600),
        headline2: TextStyle(
            color: Colors.white60, fontSize: 24, fontWeight: FontWeight.w400),
        headline3: TextStyle(
            color: Colors.white60, fontSize: 24, fontWeight: FontWeight.w400),
        bodyText1: TextStyle(color: Colors.orange[400], fontSize: 22),
        bodyText2: TextStyle(color: Colors.white60, fontSize: 18)),
    hintColor: Colors.white30,
    colorScheme: ColorScheme.dark(
        primary: Colors.white60,
        secondary: Colors.black45,
        onPrimary: Colors.orange[600]),
  );
}
