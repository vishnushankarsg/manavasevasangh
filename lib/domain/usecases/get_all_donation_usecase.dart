import 'package:manavasevasangh/domain/entities/donation_entity.dart';
import 'package:manavasevasangh/domain/repositories/firebase_repository.dart';

class GetAllDonationUsecase {
  final FirebaseRepository repository;

  GetAllDonationUsecase({this.repository});

  Stream<List<DonationEntity>> call() {
    return repository.getAllDonation();
  }
}
