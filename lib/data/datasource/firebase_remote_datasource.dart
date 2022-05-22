import 'package:manavasevasangh/domain/entities/donation_entity.dart';
import 'package:manavasevasangh/domain/entities/referal_entity.dart';
import 'package:manavasevasangh/domain/entities/user_entity.dart';

abstract class FirebaseRemoteDatasource {
  Future<void> verifyPhoneNumber(String phoneNumber);
  Future<void> signInWithPhoneNumber(String smsPinCode);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<String> getCurrentUid();
  Future<void> getCreateCurrentUser(UserEntity user);

  Future<void> getCreateDonation(DonationEntity donationUser);
  Future<void> isDonationVerified(bool isVerified);

  Stream<List<UserEntity>> getAllUser();
  Stream<List<DonationEntity>> getAllDonation();
  Stream<List<ReferalEntity>> getReferalReferee();

  Future<void> createReferalInstance(String phoneNumber, String referalId);
}
