import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(ProviderScope(child: const MobilePlus()));
  // Remove the splash after the app has been started
  FlutterNativeSplash.remove();
}
class MobilePlus extends ConsumerWidget {
  const MobilePlus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.green[50], // ensures white Scaffold
      ),
      title: 'Mobile Plus',
      home:  Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome, Mobile Plus!',
                style: TextStyle(fontSize: 24),
              ),
              TextButton(onPressed:(){}, child: Text('Click Me')),
            ],
          ),
        ),
      ),
    );
  }
}
