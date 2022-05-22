import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manavasevasangh/domain/entities/referal_entity.dart';

class ReferalModel extends ReferalEntity {
  ReferalModel({
    String phoneNumber,
    String referalId,
  }) : super(
          phoneNumber: phoneNumber,
          referalId: referalId,
        );

  factory ReferalModel.fromSnapShot(DocumentSnapshot snapshot) {
    return ReferalModel(
        phoneNumber: snapshot.data()['phoneNumber'], referalId: snapshot.data()['referalId']);
  }

  Map<String, dynamic> toDocument() {
    return {
      "phoneNumber":  phoneNumber,
      "referalId": referalId,
    };
  }
}
