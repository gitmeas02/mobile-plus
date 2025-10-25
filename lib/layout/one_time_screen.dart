import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_plus/layout/services/click_me_service.dart';
import 'package:mobile_plus/router/router.dart';

class OneTimeScreen extends ConsumerStatefulWidget {
  const OneTimeScreen({super.key});

  @override
  ConsumerState<OneTimeScreen> createState() => _OneTimeScreenState();
}

class _OneTimeScreenState extends ConsumerState<OneTimeScreen> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final service = ref.read(clickMeServiceProvider);
      final seen = await service.getSeen();
      if (seen) {
        // already seen -> go to home
        ref.read(goRouterProvider).go('/home');
        return;
      }
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome, Mobile Plus!',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () async {
                  final service = ref.read(clickMeServiceProvider);
                  await service.setSeen(true);
                  // navigate to home
                  ref.read(goRouterProvider).go('/home');
                },
                child: const Text('Click Me'),
              ),
            ],
          ),
        ),)
    );
  }
}