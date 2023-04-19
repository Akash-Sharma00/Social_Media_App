part of 'google_auth_bloc.dart';

abstract class GoogleAuthEvent extends Equatable {
  const GoogleAuthEvent();

  @override
  List<Object> get props => [];
}

class SignInRequested extends GoogleAuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);
}

class SignUpRequested extends GoogleAuthEvent {
  final String email;
  final String password;

  const SignUpRequested(this.email, this.password);
}


// ignore: must_be_immutable
class GoogleSignInRequested extends GoogleAuthEvent {
  BuildContext context;
  GoogleSignInRequested({required this.context});
}

class SignOutRequested extends GoogleAuthEvent {}
