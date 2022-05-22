import 'package:manavasevasangh/domain/repositories/firebase_repository.dart';

class CreateReferalInstanceUsecase {
  final FirebaseRepository repository;

  CreateReferalInstanceUsecase({this.repository});

  Future<void> call(String phoneNumber, String referalId) async {
    return repository.createReferalInstance(phoneNumber, referalId);
  }
}
