part of 'google_login_bloc.dart';

@immutable
sealed class GoogleLoginEvent {}

class OnGoogleLogin extends GoogleLoginEvent {}
class OnGoogleLogout extends GoogleLoginEvent {}
class OnGoogleLoginSuccess extends GoogleLoginEvent {
  final User user;

  OnGoogleLoginSuccess(this.user);
}
class OnGoogleLoginFailure extends GoogleLoginEvent {
  final String error;

  OnGoogleLoginFailure(this.error);
}