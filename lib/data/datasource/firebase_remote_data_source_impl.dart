import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manavasevasangh/data/datasource/firebase_remote_datasource.dart';
import 'package:manavasevasangh/data/model/donation_model.dart';
import 'package:manavasevasangh/data/model/referal_model.dart';
import 'package:manavasevasangh/data/model/user_model.dart';
import 'package:manavasevasangh/domain/entities/user_entity.dart';
import 'package:manavasevasangh/domain/entities/referal_entity.dart';
import 'package:manavasevasangh/domain/entities/donation_entity.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  String _verificationId = "";

  FirebaseRemoteDataSourceImpl({this.auth, this.firestore});

  @override
  Future<void> createReferalInstance(
      String phoneNumber, String referalId) async {
    final referalCollection = firestore.collection("referal");
    final uid = await getCurrentUid();
    referalCollection
        .doc(uid)
        .collection("referee")
        .doc()
        .get()
        .then((referalDoc) {
      final newReferal =
          ReferalModel(phoneNumber: phoneNumber, referalId: referalId)
              .toDocument();

      if (!referalDoc.exists) {
        referalCollection.doc(uid).collection("referee").doc().set(newReferal);
      } else {
        referalCollection
            .doc(uid)
            .collection("referee")
            .doc()
            .update(newReferal);
      }
    });
  }

  @override
  Stream<List<DonationEntity>> getAllDonation() {
    // final donationCollectionRef = firestore.collection("donation");
    // return donationCollectionRef.snapshots().map((querySnapshot) {
    //   return querySnapshot.docs
    //       .map((docDonationQuerySnapshot) =>
    //           DonationModel.fromSnapShot(docDonationQuerySnapshot))
    //       .toList();
    // });
    //
    final donationCollectionRef = firestore.collection("donation");
    return donationCollectionRef
        .where("isVerified", isEqualTo: true)
        .orderBy("supportPoint", descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((docDonationQuerySnapshot) => DonationModel.fromSnapShot(docDonationQuerySnapshot)).toList();
    });
  }

  @override
  Stream<List<UserEntity>> getAllUser() {
    final userCollectionRef = firestore.collection("users");
    return userCollectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docUserQuerySnapshot) =>
              UserModel.fromSnapshot(docUserQuerySnapshot))
          .toList();
    });
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollection = firestore.collection("users");
    final uid = await getCurrentUid();

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        fullName: user.fullName,
        phoneNumber: user.phoneNumber,
        email: user.email,
        uid: uid,
        profilePhotoUrl: user.profilePhotoUrl,
        country: user.country,
        state: user.state,
        district: user.district,
        areaPinCode: user.areaPinCode,
        userRole: user.userRole,
        isBlocked: user.isBlocked,
      ).toDocument();
      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    });
  }

  @override
  Future<void> getCreateDonation(DonationEntity donationUser) async {
    final donationCollection = firestore.collection("donation");
    final uid = await getCurrentUid();

    donationCollection.doc(uid).get().then((donationDoc) {
      final donation = DonationModel(
              title: donationUser.title,
              uid: donationUser.uid,
              fullName: donationUser.fullName,
              category: donationUser.category,
              reason: donationUser.reason,
              phoneNumber: donationUser.phoneNumber,
              address: donationUser.address,
              images: donationUser.images,
              shortDescription: donationUser.shortDescription,
              longDescription: donationUser.longDescription,
              accountDetails: donationUser.accountDetails,
              amountNeeded: donationUser.amountNeeded,
              isVerified: donationUser.isVerified)
          .toDocument();
      if (!donationDoc.exists) {
        donationCollection.doc(uid).set(donation);
      } else {
        donationCollection.doc(uid).update(donation);
      }
    });
  }

  @override
  Future<String> getCurrentUid() async => auth.currentUser.uid;

  @override
  Stream<List<ReferalEntity>> getReferalReferee() {
    final referalCollectionRef = firestore.collection("referal");
    return referalCollectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docReferalQuerySnapshot) =>
              ReferalModel.fromSnapShot(docReferalQuerySnapshot))
          .toList();
    });
  }

  @override
  Future<void> isDonationVerified(bool isVerified) async {
    final donationCollection = firestore.collection("donation");
    donationCollection
        .where("isVerified", isEqualTo: true)
        .orderBy("supportPoint", descending: true)
        .snapshots();
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser.uid != null;

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async {
    final AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsPinCode);
    await auth.signInWithCredential(authCredential);
  }

  @override
  Future<void> signOut() async => await auth.signOut();

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted phoneVerificationCompleted =
        (PhoneAuthCredential phoneAuthCredential)  {
       auth.signInWithPhoneNumber(phoneNumber);
    };

    final PhoneVerificationFailed phoneVerificationFailed =
        (FirebaseAuthException firebaseAuthException) {
      print(
        "phone failed : ${firebaseAuthException.message},${firebaseAuthException.code}",
      );
    };
    final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
        (String verificationId) {
      this._verificationId = verificationId;
      print("time out :$verificationId");
    };
    final PhoneCodeSent phoneCodeSent =
        (String verificationId, [int forceResendingToken]) {};
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: phoneVerificationFailed,
      timeout: const Duration(seconds: 120),
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
    );
  }
}
