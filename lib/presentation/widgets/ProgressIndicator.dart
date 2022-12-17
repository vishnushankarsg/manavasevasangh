import 'package:flutter/material.dart';

class ProgressDialogPrimary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var brightness =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
        ),
      ),
      backgroundColor: Theme.of(context)
          .scaffoldBackgroundColor, // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
    );
  }
}
