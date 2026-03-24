import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zk_password/data/auth/supabase_auth_service.dart';

class CloudAuthState {
  const CloudAuthState({
    this.isConfigured = false,
    this.isLoading = false,
    this.user,
    this.message,
  });

  final bool isConfigured;
  final bool isLoading;
  final User? user;
  final String? message;

  bool get isSignedIn => user != null;

  CloudAuthState copyWith({
    bool? isConfigured,
    bool? isLoading,
    Object? user = _sentinel,
    Object? message = _sentinel,
  }) {
    return CloudAuthState(
      isConfigured: isConfigured ?? this.isConfigured,
      isLoading: isLoading ?? this.isLoading,
      user: user == _sentinel ? this.user : user as User?,
      message: message == _sentinel ? this.message : message as String?,
    );
  }

  static const Object _sentinel = Object();
}

class CloudAuthController extends StateNotifier<CloudAuthState> {
  CloudAuthController(this._authService)
    : super(
        CloudAuthState(
          isConfigured: _authService.isEnabled,
          user: _authService.currentUser,
        ),
      ) {
    _subscription = _authService.authStateChanges().listen((authState) {
      state = state.copyWith(user: authState.session?.user, message: null);
    });
  }

  final SupabaseAuthService _authService;
  StreamSubscription<AuthState>? _subscription;

  Future<void> signIn({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, message: null);
    try {
      await _authService.signIn(email: email, password: password);
      state = state.copyWith(
        isLoading: false,
        user: _authService.currentUser,
        message: 'Cloud sync connected.',
      );
    } on AuthException catch (error) {
      state = state.copyWith(isLoading: false, message: error.message);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        message: 'Sign-in failed. Check your Supabase setup.',
      );
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, message: null);
    try {
      await _authService.signUp(email: email, password: password);
      state = state.copyWith(
        isLoading: false,
        user: _authService.currentUser,
        message:
            'Account created. If email confirmation is enabled, verify it first.',
      );
    } on AuthException catch (error) {
      state = state.copyWith(isLoading: false, message: error.message);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        message: 'Sign-up failed. Check your Supabase setup.',
      );
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, message: null);
    try {
      await _authService.signOut();
      state = state.copyWith(
        isLoading: false,
        user: null,
        message: 'Cloud sync disconnected.',
      );
    } catch (_) {
      state = state.copyWith(isLoading: false, message: 'Could not sign out.');
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
