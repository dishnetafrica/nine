import 'package:flutter/material.dart';

import '../../../app_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Nine ISP Suite', style: TextStyle(fontSize: 28)),
                const SizedBox(height: 12),
                const Text('Offline-first operations for Starlink and MikroTik resellers.'),
                const SizedBox(height: 24),
                TextField(decoration: const InputDecoration(labelText: 'Operator email')),
                const SizedBox(height: 12),
                TextField(obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => goToHome(context),
                  child: const Text('Sign in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
