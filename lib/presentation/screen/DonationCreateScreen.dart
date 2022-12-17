import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manavasevasangh/presentation/screen/HomeScreen.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DonationRegister extends StatefulWidget {
  @override
  _DonationRegisterState createState() => _DonationRegisterState();
}

class _DonationRegisterState extends State<DonationRegister> {
  File _image;
  final picker = ImagePicker();
  bool isLoading = false;

  String countryValue;
  String stateValue;
  String cityValue;

  

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _accountNumberController = TextEditingController();
  TextEditingController _needController = TextEditingController();
  TextEditingController _ifscController = TextEditingController();
  TextEditingController _acNameController = TextEditingController();

  bool isFullNameValidate = false;
  bool titleValidate = false;
  bool descriptionValidate = false;
  bool accountNumberValidate = false;
  bool needValidate = false;
  bool ifscValidate = false;
  bool accountValidate = false;

  

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

//     _selectDate(BuildContext context) async {
//   final DateTime picked = await showDatePicker(
//     context: context,
//     initialDate: selectedDate, // Refer step 1
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2025),
//   );
//   if (picked != null && picked != selectedDate)
//     setState(() {
//       selectedDate = picked;
//     });
// }

    bool validateNameField(String userInput) {
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

    bool validateTitleField(String userInput) {
      if (userInput.isEmpty) {
        setState(() {
          titleValidate = true;
        });
        return false;
      }
      setState(() {
        titleValidate = false;
      });
      return true;
    }

    bool validateDescriptionField(String userInput) {
      if (userInput.isEmpty) {
        setState(() {
          descriptionValidate = true;
        });
        return false;
      }
      setState(() {
        descriptionValidate = false;
      });
      return true;
    }

    bool validateAccountField(String userInput) {
      if (userInput.isEmpty) {
        setState(() {
          accountValidate = true;
        });
        return false;
      }
      setState(() {
        accountValidate = false;
      });
      return true;
    }

    bool validateAccountNumberField(String userInput) {
      if (userInput.isEmpty) {
        setState(() {
          accountNumberValidate = true;
        });
        return false;
      }
      setState(() {
        accountNumberValidate = false;
      });
      return true;
    }

    bool validateNeedField(String userInput) {
      if (userInput.isEmpty) {
        setState(() {
          needValidate = true;
        });
        return false;
      }
      setState(() {
        needValidate = false;
      });
      return true;
    }

    bool validateIfscField(String userInput) {
      if (userInput.isEmpty) {
        setState(() {
          ifscValidate = true;
        });
        return false;
      }
      setState(() {
        ifscValidate = false;
      });
      return true;
    }
    
    Future uploadPic() async {
      String fullName = _fullNameController.text;
      String title = _titleController.text;
      String needs = _needController.text;
      String description = _descriptionController.text;
      String accountNumber = _accountNumberController.text;
      String ifsc = _ifscController.text;
      String accountName = _acNameController.text;
      String country = countryValue;
      String state = stateValue;
      String city = cityValue;
      String fileName = basename(_image.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      TaskSnapshot storageTaskSnapshot =
          await firebaseStorageRef.putFile(_image);
      final dowUrl = await storageTaskSnapshot.ref.getDownloadURL();
      String imageUrl = dowUrl;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString('uid');

      final userProfileCollection =
          FirebaseFirestore.instance.collection('Donations');
      userProfileCollection.doc(uid).set({
        "userUid": uid,
        "fullName": fullName,
        "title": title,
        "description": description,
        "needs": needs,
        "accountNumber": accountNumber,
        "ifsc": ifsc,
        "accountName": accountName,
        "imageUrl": imageUrl,
        "country": country,
        "state": state,
        "city": city,
        "isVerified": false,
        // "endDate": endDate,
      });

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Apply Donation',
          style: TextStyle(
            color: Colors.orange,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
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
                              Neumorphic(
                                style: NeumorphicStyle(
                                  depth: -4.sp,
                                ),
                                child: Container(
                                  height: 50.h,
                                  alignment: Alignment.center,
                                  child: TextField(
                                    keyboardType: TextInputType.name,
                                    controller: _titleController,
                                    decoration: InputDecoration(
                                        hintText: "Title",
                                        errorText: titleValidate
                                            ? "Please enter Title"
                                            : null),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 10.h,
                              ),
                              // InkWell(
                              //   onTap: () => _selectDate(context),
                              //   child: Icon(Icons.calendar_today),
                              // ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Neumorphic(
                                style: NeumorphicStyle(
                                  depth: -4.sp,
                                ),
                                child: Container(
                                  height: 50.h,
                                  alignment: Alignment.center,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: _needController,
                                    decoration: InputDecoration(
                                        hintText: "How much You Need",
                                        errorText: needValidate
                                            ? "Please enter the amount"
                                            : null),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 10.h,
                              ),
                              Neumorphic(
                                style: NeumorphicStyle(
                                  depth: -4.sp,
                                ),
                                child: Container(
                                  height: 50.h,
                                  alignment: Alignment.center,
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    controller: _descriptionController,
                                    decoration: InputDecoration(
                                        hintText: "Short Description",
                                        errorText: descriptionValidate
                                            ? "Please enter description"
                                            : null),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 10.h,
                              ),
                              Neumorphic(
                                style: NeumorphicStyle(
                                  depth: -4.sp,
                                ),
                                child: Container(
                                  height: 50.h,
                                  alignment: Alignment.center,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: _accountNumberController,
                                    decoration: InputDecoration(
                                        hintText: "Your Bank AC Number",
                                        errorText: accountNumberValidate
                                            ? "Please enter your AC number"
                                            : null),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 10.h,
                              ),
                              Neumorphic(
                                style: NeumorphicStyle(
                                  depth: -4.sp,
                                ),
                                child: Container(
                                  height: 50.h,
                                  alignment: Alignment.center,
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    controller: _ifscController,
                                    decoration: InputDecoration(
                                        hintText: "IFSC code",
                                        errorText: ifscValidate
                                            ? "Please enter IFSC code"
                                            : null),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 10.h,
                              ),
                              Neumorphic(
                                style: NeumorphicStyle(
                                  depth: -4.sp,
                                ),
                                child: Container(
                                  height: 50.h,
                                  alignment: Alignment.center,
                                  child: TextField(
                                    keyboardType: TextInputType.name,
                                    controller: _acNameController,
                                    decoration: InputDecoration(
                                        hintText: "Account Name",
                                        errorText: accountValidate
                                            ? "Please enter AC Name"
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
                                      validateNameField(
                                          _fullNameController.text);
                                      validateTitleField(_titleController.text);
                                      validateDescriptionField(
                                          _descriptionController.text);
                                      validateNeedField(_needController.text);
                                      validateAccountNumberField(
                                          _accountNumberController.text);
                                      validateIfscField(_ifscController.text);
                                      validateAccountField(
                                          _acNameController.text);
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
    );
  }
}
