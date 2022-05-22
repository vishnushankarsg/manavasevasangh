import 'package:manavasevasangh/domain/repositories/firebase_repository.dart';

class IsDonationVerified {
  final FirebaseRepository repository;

  IsDonationVerified({this.repository});

  Future<void> call(bool isVerified) async {
    return await repository.isDonationVerified(isVerified);
  }
}
