import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_plus/router/router.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(ProviderScope(child: const MobilePlus()));
  // Remove the splash after the app has been started
  FlutterNativeSplash.remove();
}
class MobilePlus extends ConsumerStatefulWidget {
  const MobilePlus({super.key});

  @override
  ConsumerState<MobilePlus> createState() => _MobilePlusState();
}

class _MobilePlusState extends ConsumerState<MobilePlus> {
  @override
  void reassemble() {
    // Called on hot reload. Navigate to splash ('/') so the splash acts as a loading screen.
    super.reassemble();
    try {
      final router = ref.read(goRouterProvider);
      router.go('/');
    } catch (_) {
      // ignore if router isn't ready during hot reload
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.green[50], // ensures white Scaffold
      ),
      title: 'Mobile Plus',
      routerConfig: router,
    );
  }
}
