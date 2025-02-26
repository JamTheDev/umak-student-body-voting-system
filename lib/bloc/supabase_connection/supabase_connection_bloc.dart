import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:umakvotingapp/constants/shared_pref_keys.dart';

part 'supabase_connection_event.dart';
part 'supabase_connection_state.dart';

class SupabaseConnectionBloc
    extends Bloc<SupabaseConnectionEvent, SupabaseConnectionState> {
  SupabaseConnectionBloc() : super(SupabaseConnectionInitial()) {
    on<OnSupabaseConnect>((event, emit) async {
      emit(SupabaseConnectionConnecting());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      late String url = event.url ?? prefs.getString(supabaseUrlKey) ?? '';
      late String key = event.anonKey ?? prefs.getString(supabaseAnonKey) ?? '';

      try {
        final client = SupabaseClient(url, key);
        await Supabase.initialize(url: url, anonKey: key);
        emit(SupabaseConnectionConnected(client));
      } catch (e) {
        emit(SupabaseConnectionFailed(e.toString()));
      }
    });
  }
}
