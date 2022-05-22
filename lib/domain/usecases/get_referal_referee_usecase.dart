import 'package:manavasevasangh/domain/entities/referal_entity.dart';
import 'package:manavasevasangh/domain/repositories/firebase_repository.dart';

class GetReferalRefereeUsecase {
  final FirebaseRepository repository;

  GetReferalRefereeUsecase({this.repository});

  Stream<List<ReferalEntity>> call() {
    return repository.getReferalReferee();
  }
}
