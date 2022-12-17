import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:manavasevasangh/presentation/screen/ProfileSetupScreen.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static Country _selectedFilteredDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode("91");
  String _countryCode = _selectedFilteredDialogCountry.phoneCode;
  TextEditingController _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.h,
          elevation: 0,
          title: Text(
            "Registration Page",
            style: TextStyle(
                color: Colors.orange[600], fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
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
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(""),
                  Text(
                    "Verify your phone number",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Manava Seva Sangh will send and SMS message (carrier charges may apply) to verify your phone number. Enter your country code and phone number:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              ListTile(
                onTap: _openFilteredCountryPickerDialog,
                title: _buildDialogItem(_selectedFilteredDialogCountry),
              ),
              Neumorphic(
                padding: EdgeInsets.all(3.sp),
                style: NeumorphicStyle(
                  depth: -4.sp,
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 80.w,
                      height: 42.h,
                      alignment: Alignment.center,
                      child:
                          Text("${_selectedFilteredDialogCountry.phoneCode}"),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 40.h,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          controller: _phoneNumberController,
                          decoration: InputDecoration.collapsed(
                            hintText: "PhoneNumber",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: NeumorphicButton(
                    onPressed: () async {
                      String refPhoneNumber = _phoneNumberController.text;
                      final valid = await usernameCheck(refPhoneNumber);
                      if (!valid) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OtpScreen(
                                  phoneNumber:
                                      '+$_countryCode${_phoneNumberController.text}',
                                ))); // username exists
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Oops....',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                content: Text(
                                  'You are not Refered Yet',
                                ),
                              );
                            });
                      }
                    },
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      depth: 6.sp,
                    ),
                    child: Text(
                      "Verify",
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

  Future<bool> usernameCheck(refPhoneNumber) async {
    final result = await FirebaseFirestore.instance
        .collection('referal')
        .where('PhoneNumber', isEqualTo: refPhoneNumber)
        .get();
    return result.docs.isEmpty;
  }

  void _openFilteredCountryPickerDialog() {
    showDialog(
        context: context,
        useSafeArea: true,
        builder: (context) => Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Theme.of(context).colorScheme.primary,
              ),
              child: CountryPickerDialog(
                titlePadding: EdgeInsets.all(8.sp),
                searchCursorColor: Colors.black,
                searchInputDecoration: InputDecoration(
                  hintText: "Search",
                ),
                isSearchable: true,
                title: Text("Select your phone code"),
                onValuePicked: (Country country) {
                  setState(() {
                    _selectedFilteredDialogCountry = country;
                    _countryCode = country.phoneCode;
                  });
                },
                itemBuilder: _buildDialogItem,
              ),
            ));
  }

  Widget _buildDialogItem(Country country) {
    return Container(
      height: 40.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Theme.of(context).colorScheme.secondary, width: 1.w),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            height: 8.h,
          ),
          Text("+${country.phoneCode}"),
          SizedBox(
            height: 8.h,
          ),
          Text("${country.name}"),
          Spacer(),
          Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  OtpScreen({Key key, @required this.phoneNumber}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState(phoneNumber);
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.r),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  _OtpScreenState(String phoneNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('OTP Verification',
            style: Theme.of(context).textTheme.bodyText1),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40.sh),
            child: Center(
              child: Text(
                'Verify ${widget.phoneNumber}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.sp),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: PinPut(
              fieldsCount: 6,
              textStyle: TextStyle(fontSize: 25.sp, color: Colors.white),
              eachFieldWidth: 40.w,
              eachFieldHeight: 55.h,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      String uid = FirebaseAuth.instance.currentUser.uid;
                      String phoneNumber =
                          FirebaseAuth.instance.currentUser.phoneNumber;
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('uid', uid);
                      prefs.setString('phoneNumber', phoneNumber);

                      final userCollection =
                          FirebaseFirestore.instance.collection("users");
                      userCollection.doc(uid).set(
                          {'userUid': uid, 'userPhoneNumber': phoneNumber});

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfileRegister()),
                          (route) => false);
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState
                      // ignore: deprecated_member_use
                      .showSnackBar(SnackBar(content: Text('invalid OTP')));
                }
              },
            ),
          ),
          SizedBox(height: 30.h),
          CircularProgressIndicator(
            strokeWidth: 5.w,
            valueColor:
                AlwaysStoppedAnimation(Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(height: 30.h),
          Text(
            'Verifing...',
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '${widget.phoneNumber}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              String uid = FirebaseAuth.instance.currentUser.uid;
              String phoneNumber =
                  FirebaseAuth.instance.currentUser.phoneNumber;
              final prefs = await SharedPreferences.getInstance();
              prefs.setString('uid', uid);
              prefs.setString('phoneNumber', phoneNumber);
              final userCollection =
                  FirebaseFirestore.instance.collection("users");
              userCollection
                  .doc(uid)
                  .set({'userUid': uid, 'userPhoneNumber': phoneNumber});
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserProfileRegister()),
                  (route) => false);
            } else {
              print('not working');
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }
}
