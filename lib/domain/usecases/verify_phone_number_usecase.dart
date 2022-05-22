import 'package:manavasevasangh/domain/repositories/firebase_repository.dart';

class VerifyPhoneNumberUsecase {
  final FirebaseRepository repository;

  VerifyPhoneNumberUsecase({this.repository});

  Future<void> call(String phoneNumber) async {
    return await repository.verifyPhoneNumber(phoneNumber);
  }
}
