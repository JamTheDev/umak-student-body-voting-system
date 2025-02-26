part of 'supabase_connection_bloc.dart';

@immutable
sealed class SupabaseConnectionEvent {}

final class OnSupabaseConnect extends SupabaseConnectionEvent {
  late final String? url;
  late final String? anonKey;

  OnSupabaseConnect(this.url, this.anonKey);
}