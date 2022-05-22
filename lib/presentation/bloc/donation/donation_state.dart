part of 'donation_cubit.dart';

abstract class DonationState extends Equatable {
  const DonationState();

}

class DonationInitial extends DonationState {
  @override
  List<Object> get props => [];
}

class DonationSubmitSuccess extends DonationState {
  @override
  List<Object> get props => [];
}

class DonationSubmitFailure extends DonationState{
  @override
  List<Object> get props => [];
}