import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:umakvotingapp/supabase/supabase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
part 'google_login_event.dart';
part 'google_login_state.dart';

class GoogleLoginBloc extends Bloc<GoogleLoginEvent, GoogleLoginState> {
  GoogleLoginBloc() : super(GoogleLoginInitial()) {
    on<GoogleLoginEvent>((event, emit) async {
      if (event is OnGoogleLogin) {
        emit(GoogleLoginLoading());

        try {
          final GoogleSignIn googleSignIn = GoogleSignIn(
              scopes: ['email'],
              clientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'],
              hostedDomain: "umak.edu.ph");

          final googleUser = await googleSignIn.signIn();
          final googleAuth = await googleUser?.authentication;

          if (googleAuth == null) {
            emit(GoogleLoginFailure('Google Sign In Failed'));
            return;
          }

          final accessToken = googleAuth.accessToken;
          final idToken = googleAuth.idToken;

          if (accessToken == null) {
            emit(GoogleLoginFailure('Access Token is not found.'));
            return;
          }
          if (idToken == null) {
            emit(GoogleLoginFailure('ID Token is not found.'));
            return;
          }
          SupaFlow.initialize();
          final response = await SupaFlow.client.auth.signInWithIdToken(
            provider: OAuthProvider.google,
            accessToken: accessToken,
            idToken: idToken,
          );

          emit(response.user != null
              ? GoogleLoginSuccess(response.user!)
              : GoogleLoginFailure("Failed to login with Google"));
        } on Exception catch (error) {
          emit(GoogleLoginFailure(error.toString()));
          print("Supabase Login Error: $error");
        }
      }

      if (event is OnGoogleLogout) {
        await SupaFlow.client.auth.signOut();
        emit(GoogleLoginInitial());
      }
    });
  }
}
