// @dart=2.9
import 'package:manavasevasangh/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends UserEntity {
  UserModel({
    String fullName,
    String phoneNumber,
    String email,
    String uid,
    String profilePhotoUrl,
    String country,
    String state,
    String district,
    String areaPinCode,
    String userRole,
    bool isBlocked,
  }) : super(
          fullName: fullName,
          phoneNumber: phoneNumber,
          email: email,
          uid: uid,
          profilePhotoUrl: profilePhotoUrl,
          country: country,
          state: state,
          district: district,
          areaPinCode: areaPinCode,
          userRole: userRole,
          isBlocked: isBlocked,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      fullName: snapshot.data()['fullName'],
      phoneNumber: snapshot.data()['phoneNumber'],
      email: snapshot.data()['email'],
      uid: snapshot.data()['uid'],
      profilePhotoUrl: snapshot.data()['profilePhotoUrl'],
      country: snapshot.data()['country'],
      state: snapshot.data()['state'],
      district: snapshot.data()['district'],
      areaPinCode: snapshot.data()['areaPinCode'],
      userRole: snapshot.data()['isAdmin'],
      isBlocked: snapshot.data()['isBlocked'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "email": email,
      "uid": uid,
      "profilePhotoUrl": profilePhotoUrl,
      "country": country,
      "state": state,
      "district": district,
      "areaPinCode": areaPinCode,
      "isAdmin": userRole,
      "isBlocked": isBlocked,
    };
  }
}
