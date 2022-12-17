import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            size: 26.sp,
          ),
          titleTextStyle: TextStyle(color: Colors.black54, fontSize: 22.sp),
          elevation: 5.sp),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[700],
        unselectedIconTheme: IconThemeData(
          color: Colors.white60,
          size: 26.sp,
        ),
        selectedLabelStyle: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle:
            TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500),
        selectedIconTheme: IconThemeData(color: Colors.grey[500], size: 26.sp),
      ),
      cardTheme: CardTheme(
        color: Colors.grey[200],
        elevation: 5.sp,
      ),
      iconTheme: IconThemeData(
        color: Colors.black54,
        size: 30.sp,
      ),
      textTheme: TextTheme(
          headline1: TextStyle(
              color: Colors.black54,
              fontSize: 26.sp,
              fontWeight: FontWeight.w600),
          headline2: TextStyle(
              color: Colors.white70,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500),
          headline3: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600),
          bodyText1: TextStyle(color: Colors.orange[600], fontSize: 15.sp),
          bodyText2: TextStyle(color: Colors.black54, fontSize: 15.sp)),
      hintColor: Colors.black45,
      colorScheme: ColorScheme.light(
          primary: Colors.grey,
          secondary: Colors.white,
          onPrimary: Colors.orange[600]));

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[800],
    primaryColor: Colors.grey[800],
    dividerColor: Colors.white,
    appBarTheme: AppBarTheme(
        color: Colors.grey[800],
        iconTheme: IconThemeData(
          color: Colors.white60,
          size: 26.sp,
        ),
        titleTextStyle: TextStyle(color: Colors.white60, fontSize: 22.sp),
        elevation: 5.sp),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[700],
      unselectedIconTheme: IconThemeData(
        color: Colors.grey[200],
        size: 26.sp,
      ),
      selectedLabelStyle: TextStyle(
        color: Colors.amber,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle:
          TextStyle(color: Colors.grey[200], fontWeight: FontWeight.w500),
      selectedIconTheme: IconThemeData(color: Colors.amber, size: 26.sp),
    ),
    cardTheme: CardTheme(
      color: Colors.grey[800],
      elevation: 5.sp,
    ),
    iconTheme: IconThemeData(
      color: Colors.white60,
      size: 30.sp,
    ),
    textTheme: TextTheme(
        headline1: TextStyle(
            color: Colors.white60,
            fontSize: 26.sp,
            fontWeight: FontWeight.w600),
        headline2: TextStyle(
            color: Colors.white60,
            fontSize: 24.sp,
            fontWeight: FontWeight.w400),
        headline3: TextStyle(
            color: Colors.white60,
            fontSize: 24.sp,
            fontWeight: FontWeight.w400),
        bodyText1: TextStyle(color: Colors.orange[400], fontSize: 15.sp),
        bodyText2: TextStyle(color: Colors.white60, fontSize: 15.sp)),
    hintColor: Colors.white30,
    colorScheme: ColorScheme.dark(
        primary: Colors.white38,
        secondary: Colors.black45,
        onPrimary: Colors.orange[600]),
  );
}
