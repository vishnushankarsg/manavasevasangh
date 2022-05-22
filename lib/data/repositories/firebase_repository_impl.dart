import 'package:manavasevasangh/data/datasource/firebase_remote_datasource.dart';
import 'package:manavasevasangh/domain/entities/user_entity.dart';
import 'package:manavasevasangh/domain/entities/referal_entity.dart';
import 'package:manavasevasangh/domain/entities/donation_entity.dart';
import 'package:manavasevasangh/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDatasource remoteDatasource;
  FirebaseRepositoryImpl({this.remoteDatasource});

  @override
  Future<void> createReferalInstance(
          String phoneNumber, String referalId) async =>
      await remoteDatasource.createReferalInstance(phoneNumber, referalId);


  @override
  Stream<List<DonationEntity>> getAllDonation() =>
      remoteDatasource.getAllDonation();

  @override
  Stream<List<UserEntity>> getAllUser() => remoteDatasource.getAllUser();

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
      await remoteDatasource.getCreateCurrentUser(user);

  @override
  Future<void> getCreateDonation(DonationEntity donationUser) async =>
      await remoteDatasource.getCreateDonation(donationUser);

  @override
  Future<String> getCurrentUid() async =>
      await remoteDatasource.getCurrentUid();

  @override
  Stream<List<ReferalEntity>> getReferalReferee() =>
      remoteDatasource.getReferalReferee();

  @override
  Future<void> isDonationVerified(bool isVerified) async =>
      await remoteDatasource.isDonationVerified(isVerified);


  @override
  Future<bool> isSignIn() async => await remoteDatasource.isSignIn();

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async =>
      await remoteDatasource.signInWithPhoneNumber(smsPinCode);

  @override
  Future<void> signOut() async => await remoteDatasource.signOut();

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async =>
      await remoteDatasource.verifyPhoneNumber(phoneNumber);
}
