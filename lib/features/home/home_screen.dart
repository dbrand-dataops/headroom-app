import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/state/auth_controller.dart';
import '../auth/state/auth_state.dart';

/// Placeholder Home screen for Phase 1. The bucket UI, entries, patterns
/// and share features land in Phase 2.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthState authState = ref.watch(authControllerProvider);
    final String greeting = switch (authState) {
      AuthAuthenticated(:final user) => user.displayName?.trim().isNotEmpty ?? false
          ? user.displayName!
          : user.email,
      _ => '',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Headroom'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome, $greeting',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
