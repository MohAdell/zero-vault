import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  const SupabaseAuthService(this._client);

  final SupabaseClient? _client;

  bool get isEnabled => _client != null;
  User? get currentUser => _client?.auth.currentUser;

  Stream<AuthState> authStateChanges() {
    final client = _client;
    if (client == null) {
      return const Stream<AuthState>.empty();
    }

    return client.auth.onAuthStateChange;
  }

  Future<void> signIn({required String email, required String password}) async {
    final client = _requireClient();
    await client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signUp({required String email, required String password}) async {
    final client = _requireClient();
    await client.auth.signUp(email: email, password: password);
  }

  Future<void> signOut() async {
    final client = _client;
    if (client == null) {
      return;
    }

    await client.auth.signOut();
  }

  SupabaseClient _requireClient() {
    final client = _client;
    if (client == null) {
      throw StateError('Supabase is not configured.');
    }
    return client;
  }
}
