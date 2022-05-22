import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manavasevasangh/domain/entities/user_entity.dart';
import 'package:manavasevasangh/domain/usecases/get_create_current_user_usecase.dart';
import 'package:manavasevasangh/domain/usecases/signin_with_phonenumber_usecase.dart';
import 'package:manavasevasangh/domain/usecases/verify_phone_number_usecase.dart';

part 'phoneauth_state.dart';

class PhoneauthCubit extends Cubit<PhoneAuthState> {
  final SignInWithPhoneNumberUsecase signInWithPhoneNumberUseCase;
  final VerifyPhoneNumberUsecase verifyPhoneNumberUseCase;
  final GetCreateCurrentUserUsecase getCreateCurrentUserUseCase;

  PhoneauthCubit({
    this.signInWithPhoneNumberUseCase,
    this.verifyPhoneNumberUseCase,
    this.getCreateCurrentUserUseCase,
  }) : super(PhoneAuthInitial());

  Future<void> submitVerifyPhoneNumber({String phoneNumber}) async {
    emit(PhoneAuthLoading());
    try {
      await verifyPhoneNumberUseCase.call(phoneNumber);
      emit(PhoneAuthSmsCodeReceived());
    } on SocketException catch (_) {
      emit(PhoneAuthFailure());
    } catch (_) {
      emit(PhoneAuthFailure());
    }
  }

  Future<void> submitSmsCode({String smsCode}) async {
    emit(PhoneAuthLoading());
    try {
      await signInWithPhoneNumberUseCase.call(smsCode);
      emit(PhoneAuthProfileInfo());
    } on SocketException catch (_) {
      emit(PhoneAuthFailure());
    } catch (_) {
      emit(PhoneAuthFailure());
    }
  }

  Future<void> submitProfileInfo({
    String fullname,
    String profilePhotoUrl,
    String phoneNumber,
    String email,
    String uid,
    String country,
    String state,
    String district,
    String areaPinCode,
    String userRole,
    bool isBlocked,
    

  }) async {
    try {
      await getCreateCurrentUserUseCase.call(UserEntity(
        uid: uid,
        fullName: fullname,
        phoneNumber: phoneNumber,
        email: email,
        profilePhotoUrl: profilePhotoUrl,
        country: country,
        state: state,
        district: district,
        areaPinCode: areaPinCode,
        userRole: userRole,
        isBlocked: isBlocked
      ));
      emit(PhoneAuthSuccess());
    } on SocketException catch (_) {
      emit(PhoneAuthFailure());
    } catch (_) {
      emit(PhoneAuthFailure());
    }
  }
}
