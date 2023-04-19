import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/all_routes/routes_const.dart';
import 'package:social_media/screens/auth/google_signin.dart';

part 'google_auth_event.dart';
part 'google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  GoogleAuthBloc() : super(GoogleAuthInitial()) {
    on<GoogleAuthEvent>((event, emit) {});
    on<GoogleSignInRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        UserCredential userCredential = await AuthFeature().signInWithGoogle();
        emit(Authenticated(userCredential: userCredential));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
      User? auth = FirebaseAuth.instance.currentUser;
      if (auth != null) {
        // ignore: use_build_context_synchronously
        GoRouter.of(event.context).pushReplacementNamed(RouteName.homescreen);
      }
    });
  }
}
