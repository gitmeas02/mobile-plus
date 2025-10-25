import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_plus/layout/services/click_me_service.dart';
import 'package:mobile_plus/router/router.dart';

/// How long to show the splash when acting as a loading screen (hot reload or manual navigation).
const Duration kSplashDelay = Duration(milliseconds: 600);

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initAsync();
    });
  }

  Future<void> _initAsync() async {
    final service = ref.read(clickMeServiceProvider);
    final seen = await service.getSeen();

    // Add a short delay so the splash is visible as a loading screen
    await Future.delayed(kSplashDelay);

    if (seen) {
      ref.read(goRouterProvider).go('/home');
    } else {
      ref.read(goRouterProvider).go('/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mobile Plus',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

/// Show an in-app splash-like loading overlay. Does not change router state.
Future<void> showSplashOverlay(BuildContext context) async {
  // Use root navigator so it displays above any nested navigators.
  showDialog(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
    builder: (c) => const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Mobile Plus',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    ),
  );

  await Future.delayed(kSplashDelay);
  Navigator.of(context, rootNavigator: true).pop();
}