import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manavasevasangh/domain/entities/donation_entity.dart';
import 'package:manavasevasangh/domain/usecases/get_create_donation_usecase.dart';

part 'donation_state.dart';

class DonationCubit extends Cubit<DonationState> {
  final GetCreateDonationUsecase getCreateDonationUsecase;
  DonationCubit({
    this.getCreateDonationUsecase,
  }) : super(DonationInitial());


  Future<void> submitDonationInfo({
    String title,
    String uid,
    String fullName,
    String category,
    String reason,
    String phoneNumber,
    Map accountDetails,
    Map address,
    Map images,
    String shortDescription,
    String longDescription,
    String amountNeeded,
    bool isVerified,
  }) async {
    try {
      await getCreateDonationUsecase.call(DonationEntity(
        title: title,
        uid: uid,
        fullName: fullName,
        category: category,
        reason: reason,
        phoneNumber: phoneNumber,
        address: address,
        images: images,
        shortDescription: shortDescription,
        longDescription: longDescription,
        accountDetails: accountDetails,
        amountNeeded: amountNeeded,
        isVerified: isVerified,
      ));
      emit(DonationSubmitSuccess());
    } on SocketException catch (_) {
      emit(DonationSubmitFailure());
    } catch (_) {
      emit(DonationSubmitFailure());
    }
  }
}
