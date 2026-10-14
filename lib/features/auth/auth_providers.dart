import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_repository.dart';

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(FirebaseAuth.instance));

final authStateProvider = StreamProvider<User?>(
  (ref) => ref.watch(authRepositoryProvider).authStateChanges(),
);