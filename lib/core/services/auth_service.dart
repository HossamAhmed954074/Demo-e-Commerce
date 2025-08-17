import 'dart:async';
import 'dart:developer' as dev;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo_ecommerce/core/models/auth_result.dart';
import 'package:demo_ecommerce/core/models/app_user.dart';
// validation is handled in form fields; no validation utils here
import 'package:demo_ecommerce/core/errors/firebase_faliure.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  // Singleton
  static AuthService? _instance;
  factory AuthService() =>
      _instance ??= AuthService._internal(FirebaseAuth.instance);
  AuthService._internal(this._firebaseAuth);

  /// Stream of authentication state as `AppUser?`.
  Stream<AppUser?> get authStateChanges => _firebaseAuth.authStateChanges().map(
    (u) => u != null ? AppUser.fromFirebaseUser(u) : null,
  );

  /// Current signed-in user or null.
  AppUser? get currentUser {
    final u = _firebaseAuth.currentUser;
    return u != null ? AppUser.fromFirebaseUser(u) : null;
  }

  /// Whether a user is currently signed in.
  bool get isLoggedIn => _firebaseAuth.currentUser != null;

  /// Sign in with email and password.
  Future<AuthResult<AppUser>> signIn(String email, String password) async {
    try {
      final cred = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user == null) return AuthResult.error('Sign in failed');
      return AuthResult.success(AppUser.fromFirebaseUser(user));
    } on FirebaseAuthException catch (e) {
      dev.log('SignIn error: ${e.code}');
      final msg = FirebaseFaliure(e.code).faliure();
      return AuthResult.error(msg);
    } catch (e) {
      dev.log('SignIn unexpected error: $e');
      return AuthResult.error('An unexpected error occurred');
    }
  }

  /// Register (create account) with email and password.
  Future<AuthResult<AppUser>> register(
    String email,
    String password, {
    String? displayName,
  }) async {
    try {
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user;
      if (user == null) return AuthResult.error('Registration failed');

      if (displayName != null) {
        await user.updateDisplayName(displayName);
      }

      return AuthResult.success(AppUser.fromFirebaseUser(user));
    } on FirebaseAuthException catch (e) {
      dev.log('Register error: ${e.code}');
      final msg = FirebaseFaliure(e.code).faliure();
      return AuthResult.error(msg);
    } catch (e) {
      dev.log('Register unexpected error: $e');
      return AuthResult.error('An unexpected error occurred');
    }
  }

  /// Sign out
  Future<AuthResult<void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return AuthResult.success(null);
    } catch (e) {
      dev.log('SignOut error: $e');
      return AuthResult.error('Failed to sign out');
    }
  }


}
