import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    final url = dotenv.env['SUPABASE_URL'];
    final anonKey = dotenv.env['SUPABASE_ANON_KEY'];
    Supabase supabase;

    // Initialize Supabase with the loaded values
    if (url!.isNotEmpty && anonKey!.isNotEmpty) {
      print('[Supabase] Anon Key: $anonKey');
      print('[Supabase] URL: $url');

      try {
        supabase = await Supabase.initialize(
          url: url,
          anonKey: anonKey,
          debug: true,
        );

        final session = supabase.client.auth.currentSession;
        print(
            '[Supabase] Initial session: ${session != null ? 'exists' : 'null'}');
        if (session != null) {
          print('[Supabase] User ID: ${session.user.id}');
          // Create auth user wrapper and update app state
          // Initialize your auth here
          //final authUser = FlutterAppSupabaseUser(session.user);
          //AppStateNotifier.instance.update(authUser);
        }
      } catch (e) {
        log('[Supabase] Error initializing Supabase: $e');
      }
    }
  }
}
