import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manavasevasangh/presentation/screen/HomeScreen.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class UserProfileRegister extends StatefulWidget {
  @override
  _UserProfileRegisterState createState() => _UserProfileRegisterState();
}

class _UserProfileRegisterState extends State<UserProfileRegister> {
  File _image;
  final picker = ImagePicker();
  bool isLoading = false;

  String countryValue;
  String stateValue;
  String cityValue;

  TextEditingController _fullNameController = TextEditingController();
  bool isFullNameValidate = false;
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.camera);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }

    bool validateTextField(String userInput) {
      if (userInput.isEmpty) {
        setState(() {
          isFullNameValidate = true;
        });
        return false;
      }
      setState(() {
        isFullNameValidate = false;
      });
      return true;
    }

    Future uploadPic() async {
      String uid = FirebaseAuth.instance.currentUser.uid;
      String fullName = _fullNameController.text;
      String country = countryValue;
      String state = stateValue;
      String city = cityValue;
      String fileName = basename(_image.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      TaskSnapshot storageTaskSnapshot =
          await firebaseStorageRef.putFile(_image);
      final dowUrl = await storageTaskSnapshot.ref.getDownloadURL();
      String photoUrl = dowUrl;

      final userProfileCollection =
          FirebaseFirestore.instance.collection('users');
      userProfileCollection.doc(uid).update({
        "fullName": fullName,
        "photoUrl": photoUrl,
        "country": country,
        "state": state,
        "city": city,
        "role": "user",
        "isBlocked": false,
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('fullName', fullName);
      prefs.setString('photoUrl', photoUrl);
      setState(() {
        isLoading = false;
      });

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Profile Setup',
            style: TextStyle(
              color: Colors.orange,
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios, size: 25.sp),
          ),
        ),
        body: Container(
          
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : new SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                getImage();
                              },
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                  depth: -4.sp,
                                  boxShape: NeumorphicBoxShape.circle(),
                                ),
                                child: CircleAvatar(
                                  radius: 100.r,
                                  backgroundColor: Colors.transparent,
                                  child: ClipOval(
                                    child: new SizedBox(
                                      width: 180.w,
                                      height: 180.h,
                                      child: (_image != null)
                                          ? Image.file(
                                              _image,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.asset(
                                              "assets/images/avatarimage.png",
                                              fit: BoxFit.fitWidth,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.all(10.sp),
                        child: Neumorphic(
                          style: NeumorphicStyle(
                            depth: 4.sp,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10.sp),
                            child: Column(
                              children: [
                                Neumorphic(
                                  style: NeumorphicStyle(
                                    depth: -4.sp,
                                  ),
                                  child: Container(
                                    height: 50.h,
                                    alignment: Alignment.center,
                                    child: TextField(
                                      keyboardType: TextInputType.name,
                                      controller: _fullNameController,
                                      decoration: InputDecoration(
                                          hintText: "Your Full Name",
                                          errorText: isFullNameValidate
                                              ? "Please enter your Name"
                                              : null),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SelectState(
                                  dropdownColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  onCountryChanged: (value) {
                                    setState(() {
                                      countryValue = value;
                                    });
                                  },
                                  onStateChanged: (value) {
                                    setState(() {
                                      stateValue = value;
                                    });
                                  },
                                  onCityChanged: (value) {
                                    setState(() {
                                      cityValue = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: NeumorphicButton(
                                      onPressed: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        validateTextField(
                                            _fullNameController.text);
                                        uploadPic();
                                      },
                                      style: NeumorphicStyle(
                                        shape: NeumorphicShape.convex,
                                        boxShape: NeumorphicBoxShape.circle(),
                                        depth: 4.sp,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        size: 50.sp,
                                      )),
                                ),
                                SizedBox(
                                  height: 20.h,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
