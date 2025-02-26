import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
// import '/flutter_flow/nav/nav.dart';

export 'database/database.dart';

class SupaFlow {
  SupaFlow();

  static SupaFlow? _instance;
  static SupaFlow get instance => _instance ??= SupaFlow._();

  final _supabase = Supabase.instance.client;
  static SupabaseClient get client => instance._supabase;

  // The keys for SharedPreferences
  static const String _prefsSupabaseUrl = 'supabaseUrl';
  static const String _prefsSupabaseAnonKey = 'supabaseAnonKey';

  // Private constructor
  SupaFlow._();

  static Future initialize() async {
    // Retrieve stored values from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString(_prefsSupabaseUrl) ?? '';
    final anonKey = prefs.getString(_prefsSupabaseAnonKey) ?? '';

    // Initialize Supabase with the loaded values
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
      debug: false,
    );

    final session = Supabase.instance.client.auth.currentSession;
    print('[Supabase] Initial session: ${session != null ? 'exists' : 'null'}');
    if (session != null) {
      print('[Supabase] User ID: ${session.user.id}');
      // Create auth user wrapper and update app state
      // Initialize your auth here
      //final authUser = FlutterAppSupabaseUser(session.user);
      //AppStateNotifier.instance.update(authUser);
    }
  }
}
