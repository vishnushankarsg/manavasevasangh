import 'package:manavasevasangh/domain/entities/donation_entity.dart';
import 'package:manavasevasangh/domain/repositories/firebase_repository.dart';

class GetCreateDonationUsecase {
  final FirebaseRepository repository;

  GetCreateDonationUsecase({this.repository});

  Future<void> call(DonationEntity donationUser) async {
    return await repository.getCreateDonation(donationUser);
  }
}
