part of 'google_auth_bloc.dart';

abstract class GoogleAuthState extends Equatable {
  const GoogleAuthState();

 
}

class GoogleAuthInitial extends GoogleAuthState {
   @override
  List<Object> get props => [];
}
class AuthLoading extends GoogleAuthState {
   @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class Authenticated extends GoogleAuthState {
  UserCredential userCredential;
  Authenticated({required this.userCredential});
  @override
  List<Object?> get props => [userCredential];
}

class UnAuthenticated extends GoogleAuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends GoogleAuthState {
  final String error;

  const AuthError(this.error);
  @override
  List<Object?> get props => [error];
}
