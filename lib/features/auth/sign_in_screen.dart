import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_providers.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('ORBIT', style: TextStyle(fontSize: 32)),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () async {
                try {
                  await ref.read(authRepositoryProvider).signInWithGoogle();
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sign-in failed: $e')),
                    );
                  }
                }
              },
              child: const Text('Continue with Google'),
            ),
          ],
        ),
      ),
    );
  }
}