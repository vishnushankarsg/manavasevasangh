import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:manavasevasangh/presentation/ThemeData/ThemeData.dart';
import 'package:manavasevasangh/presentation/screen/HomeScreen.dart';
import 'package:manavasevasangh/presentation/screen/MainScreen.dart';
import 'package:manavasevasangh/presentation/screen/ProfileSetupScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString('uid');
  var phoneNumber = prefs.getString('phoneNumber');
  var fullName = prefs.getString('fullName');
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
      color: Colors.transparent,
      child: Text(
        details.toString(),
        style: TextStyle(
          fontSize: 15.sp,
          color: Colors.transparent,
        ),
      ),
    );
  };
  Firebase.initializeApp();
  runApp(
    ScreenUtilInit(
      builder: () => MaterialApp(
        home: uid == null && phoneNumber == null
            ? MainScreen()
            : fullName == null
                ? UserProfileRegister()
                : HomeScreen(),
        debugShowCheckedModeBanner: false,
        title: 'Manava Seva Sangh',
        theme: AppTheme.lightTheme, // ThemeData(primarySwatch: Colors.blue),
        darkTheme: AppTheme.darkTheme, // ThemeData(primarySwatch: Colors.blue),
      ),
      designSize: const Size(360, 640),
    ),
  );
}
