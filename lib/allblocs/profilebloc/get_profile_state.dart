// ignore_for_file: must_be_immutable

part of 'get_profile_bloc.dart';

abstract class GetProfileState extends Equatable {
  const GetProfileState();
}

class GetProfileInitial extends GetProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoaded extends GetProfileState {
  ProfileModel profileModel;
  ProfileLoaded({required this.profileModel});
  @override
  List<ProfileModel> get props => [profileModel];
}

class ProfilError extends GetProfileState {
  String error;
  ProfilError({required this.error});
  @override
  List<Object> get props => [error];
}
