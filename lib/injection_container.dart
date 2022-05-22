import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:manavasevasangh/data/datasource/firebase_remote_data_source_impl.dart';
import 'package:manavasevasangh/data/datasource/firebase_remote_datasource.dart';
import 'package:manavasevasangh/data/repositories/firebase_repository_impl.dart';
import 'package:manavasevasangh/domain/repositories/firebase_repository.dart';
import 'package:manavasevasangh/domain/usecases/get_all_user_usecase.dart';
import 'package:manavasevasangh/domain/usecases/get_create_current_user_usecase.dart';
import 'package:manavasevasangh/domain/usecases/get_current_uid_usecase.dart';
import 'package:manavasevasangh/domain/usecases/is_signin_usecase.dart';
import 'package:manavasevasangh/domain/usecases/is_signout_usecase.dart';
import 'package:manavasevasangh/domain/usecases/signin_with_phonenumber_usecase.dart';
import 'package:manavasevasangh/domain/usecases/verify_phone_number_usecase.dart';
import 'package:manavasevasangh/presentation/bloc/auth/auth_cubit.dart';
import 'package:manavasevasangh/presentation/bloc/donation/donation_cubit.dart';
import 'package:manavasevasangh/presentation/bloc/phoneAuth/phoneauth_cubit.dart';
import 'package:manavasevasangh/presentation/bloc/user/user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<AuthCubit>(() => AuthCubit(
        signOutUseCase: sl.call(),
        isSignInUseCase: sl.call(),
        getCurrentUidUseCase: sl.call(),
      ));

  sl.registerFactory<PhoneauthCubit>(() => PhoneauthCubit(
        getCreateCurrentUserUseCase: sl.call(),
        signInWithPhoneNumberUseCase: sl.call(),
        verifyPhoneNumberUseCase: sl.call(),
      ));

  sl.registerFactory<UserCubit>(() => UserCubit(
        getAllUserUseCase: sl.call(),
      ));

  sl.registerFactory<DonationCubit>(() => DonationCubit(
        getCreateDonationUsecase: sl.call(),
      ));

  sl.registerLazySingleton<GetCreateCurrentUserUsecase>(
      () => GetCreateCurrentUserUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInWithPhoneNumberUsecase>(
      () => SignInWithPhoneNumberUsecase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<VerifyPhoneNumberUsecase>(
      () => VerifyPhoneNumberUsecase(repository: sl.call()));

  sl.registerLazySingleton<GetAllUserUseCase>(
      () => GetAllUserUseCase(repository: sl.call()));

  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDatasource: sl.call()));

  sl.registerLazySingleton<FirebaseRemoteDatasource>(
      () => FirebaseRemoteDataSourceImpl(
            auth: sl.call(),
            firestore: sl.call(),
          ));

  //External

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
