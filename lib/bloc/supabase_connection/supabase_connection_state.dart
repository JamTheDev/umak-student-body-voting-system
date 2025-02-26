part of 'supabase_connection_bloc.dart';

@immutable
sealed class SupabaseConnectionState {}

final class SupabaseConnectionInitial extends SupabaseConnectionState {}

final class SupabaseConnectionConnecting extends SupabaseConnectionInitial {}

final class SupabaseConnectionFailed extends SupabaseConnectionInitial {
  final String error;

  SupabaseConnectionFailed(this.error);
}

final class SupabaseConnectionConnected extends SupabaseConnectionInitial {
  final SupabaseClient client;

  SupabaseConnectionConnected(this.client);
}
