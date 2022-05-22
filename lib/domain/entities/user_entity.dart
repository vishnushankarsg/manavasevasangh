import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String uid;
  final String profilePhotoUrl;
  final String country;
  final String state;
  final String district;
  final String areaPinCode;
  final String userRole;
  final bool isBlocked;

  UserEntity({
    this.fullName,
    this.phoneNumber,
    this.email,
    this.uid,
    this.profilePhotoUrl,
    this.country,
    this.state,
    this.district,
    this.areaPinCode,
    this.userRole,
    this.isBlocked,
  });

  @override
  List<Object> get props => [
        fullName,
        phoneNumber,
        email,
        uid,
        profilePhotoUrl,
        country,
        state,
        district,
        areaPinCode,
        userRole,
        isBlocked,
      ];
}
