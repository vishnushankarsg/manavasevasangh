import 'package:equatable/equatable.dart';

class ReferalEntity extends Equatable {
  final String phoneNumber;
  final String referalId;

  ReferalEntity({
    this.phoneNumber,
    this.referalId,
  });

  @override
  List<Object> get props => [
        phoneNumber,
        referalId,
      ];
}
