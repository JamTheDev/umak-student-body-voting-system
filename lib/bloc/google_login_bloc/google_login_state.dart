part of 'google_login_bloc.dart';

@immutable
sealed class GoogleLoginState {}

final class GoogleLoginInitial extends GoogleLoginState {}

final class GoogleLoginLoading extends GoogleLoginState {}

final class GoogleLoginSuccess extends GoogleLoginState {
  final User user;

  GoogleLoginSuccess(this.user);
}

final class GoogleLoginFailure extends GoogleLoginState {
  final String error;

  GoogleLoginFailure(this.error);
}
