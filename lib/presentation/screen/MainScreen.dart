import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:manavasevasangh/presentation/screen/RegistrationScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NeumorphicText(
                  "Welcome to \n Manava Seva Sangh",
                  textAlign: TextAlign.center,
                  style: NeumorphicStyle(color: Colors.orange[400], depth: 3),
                  textStyle: NeumorphicTextStyle(
                      fontSize: 32.sp, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Read our Privacy Policy Tap, 'Agree and continue' to accept the Terms of Service",
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                NeumorphicButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return RegistrationScreen();
                    }));
                  },
                  child: Text("AGREE AND CONTINUE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold)),
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    depth: 6,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
