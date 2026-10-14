import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  AuthRepository(this._auth);

  final FirebaseAuth _auth;
  bool _googleReady = false;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<void> signInWithGoogle() async {
    final google = GoogleSignIn.instance;
    if (!_googleReady) {
      await google.initialize();
      _googleReady = true;
    }
    final account = await google.authenticate();
    final credential = GoogleAuthProvider.credential(
      idToken: account.authentication.idToken,
    );
    await _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await _auth.signOut();
  }
}