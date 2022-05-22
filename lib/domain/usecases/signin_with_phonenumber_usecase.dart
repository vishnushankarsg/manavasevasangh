import 'package:manavasevasangh/domain/repositories/firebase_repository.dart';

class SignInWithPhoneNumberUsecase {
  final FirebaseRepository repository;

  SignInWithPhoneNumberUsecase({this.repository});

  Future<void> call(String smsPinCode) async {
    return await repository.signInWithPhoneNumber(smsPinCode);
  }
}
