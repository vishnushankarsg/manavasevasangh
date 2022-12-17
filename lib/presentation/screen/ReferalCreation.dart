import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:manavasevasangh/presentation/screen/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ReferalCreation extends StatefulWidget {
  @override
  _ReferalCreationState createState() => _ReferalCreationState();
}

class _ReferalCreationState extends State<ReferalCreation> {
  bool isLoading = false;
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  bool nameValidate = false;
  bool phoneNumberValidate = false;

  @override
  Widget build(BuildContext context) {
    bool validateNameField(String userInput) {
      if (userInput.isEmpty) {
        setState(() {
          nameValidate = true;
        });
        return false;
      }
      setState(() {
        nameValidate = false;
      });
      return true;
    }

    bool phoneNumberField(String userInput) {
      if (userInput.isEmpty) {
        setState(() {
          phoneNumberValidate = true;
        });
        return false;
      }
      setState(() {
        phoneNumberValidate = false;
      });
      return true;
    }

    Future uploadPic() async {
      String name = _nameController.text;
      String phoneNumber = _phoneNumberController.text;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString('uid');

      final userProfileCollection =
          FirebaseFirestore.instance.collection('referal');
      userProfileCollection.doc().set({
        "Uid": uid,
        "name": name,
        "PhoneNumber": phoneNumber,
      });

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    }

    return SafeArea(
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : new Scaffold(
              appBar: AppBar(
                toolbarHeight: 80.sp,
                elevation: 0,
                title: Text(
                  "Referal Registration",
                  style: TextStyle(
                      color: Colors.orange[600], fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                leading: InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 25.sp,
                  ),
                ),
              ),
              body: Container(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(""),
                        Text(
                          "Refer using Phone Number",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Neumorphic(
                      padding: EdgeInsets.all(3.sp),
                      style: NeumorphicStyle(
                        depth: -4.sp,
                      ),
                      child: Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 40.h,
                          child: TextField(
                            keyboardType: TextInputType.name,
                            controller: _nameController,
                            decoration: InputDecoration(
                                hintText: "Name",
                                errorText: nameValidate
                                    ? "Please enter your Name"
                                    : null),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Neumorphic(
                      padding: EdgeInsets.all(3.sp),
                      style: NeumorphicStyle(
                        depth: -4.sp,
                      ),
                      child: Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 40.h,
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                                hintText: "98XXXXXXXX",
                                errorText: phoneNumberValidate
                                    ? "Please enter your Name"
                                    : null),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: NeumorphicButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            validateNameField(_nameController.text);
                            phoneNumberField(_phoneNumberController.text);
                            uploadPic();
                          },
                          style: NeumorphicStyle(
                            shape: NeumorphicShape.convex,
                            depth: 6.sp,
                          ),
                          child: Text(
                            "Add Referal",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
