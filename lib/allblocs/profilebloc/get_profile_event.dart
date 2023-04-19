part of 'get_profile_bloc.dart';

class GetProfileEvent extends Equatable {
  const GetProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileDataLoaded extends GetProfileEvent {}

class ProfileDataError extends GetProfileEvent {}
