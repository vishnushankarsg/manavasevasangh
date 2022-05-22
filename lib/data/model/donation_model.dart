import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manavasevasangh/domain/entities/donation_entity.dart';

class DonationModel extends DonationEntity {
  DonationModel(
      {String title,
      String uid,
      String fullName,
      String category,
      String reason,
      String phoneNumber,
      Map address,
      Map images,
      String shortDescription,
      String longDescription,
      Map accountDetails,
      String amountNeeded,
      bool isVerified})
      : super(
          title: title,
          uid: uid,
          fullName: fullName,
          category: category,
          reason: reason,
          phoneNumber: phoneNumber,
          address: address,
          images: images,
          shortDescription: shortDescription,
          longDescription: longDescription,
          accountDetails: accountDetails,
          amountNeeded: amountNeeded,
          isVerified: isVerified,
        );

  factory DonationModel.fromSnapShot(DocumentSnapshot snapshot) {
    return DonationModel(
        title: snapshot.data()['title'],
        uid: snapshot.data()['uid'],
        fullName: snapshot.data()['fullName'],
        category: snapshot.data()['category'],
        reason: snapshot.data()['reason'],
        phoneNumber: snapshot.data()['phoneNumber'],
        address: snapshot.data()['address'],
        images: snapshot.data()['images'],
        shortDescription: snapshot.data()['shortDescription'],
        longDescription: snapshot.data()['longDescription'],
        accountDetails: snapshot.data()['accountDetails'],
        amountNeeded: snapshot.data()['amountNeeded'],
        isVerified: snapshot.data()['isVerified']);
  }

  Map<String, dynamic> toDocument() {
    return {
      "title": title,
      "uid": uid,
      "fullName": fullName,
      "category": category,
      "reason": reason,
      "phoneNumber": phoneNumber,
      "address": address,
      "images": images,
      "shortDescription": shortDescription,
      "longDescription": longDescription,
      "accountDetails": accountDetails,
      "amountNeeded": amountNeeded,
      "isVerified": isVerified,
    };
  }
}
