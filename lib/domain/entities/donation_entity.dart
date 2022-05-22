import 'package:equatable/equatable.dart';

class DonationEntity extends Equatable {
  final String title;
  final String uid;
  final String fullName;
  final String category;
  final String reason;
  final String phoneNumber;
  final Map address;
  final Map images;
  final String shortDescription;
  final String longDescription;
  final Map accountDetails;
  final String amountNeeded;
  final bool isVerified;

  DonationEntity({
    this.title,
    this.uid,
    this.fullName,
    this.category,
    this.reason,
    this.phoneNumber,
    this.address,
    this.images,
    this.shortDescription,
    this.longDescription,
    this.accountDetails,
    this.amountNeeded,
    this.isVerified,
  });

  @override
  List<Object> get props => [
        title,
        uid,
        fullName,
        category,
        reason,
        phoneNumber,
        address,
        images,
        shortDescription,
        longDescription,
        accountDetails,
        amountNeeded,
        isVerified,
      ];
}
