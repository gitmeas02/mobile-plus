import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MobilePlus());
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
          brightness: Brightness.light, // 👈 light mode for white background
        ),
        scaffoldBackgroundColor: Colors.green[50], // ensures white Scaffold
      ),
      title: 'Flutter Demo',
      home:  Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello, Mobile Plus!',
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
