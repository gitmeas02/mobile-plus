import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_plus/core/widgets/shimmer_loading_states.dart';
import 'package:mobile_plus/features/home/data/providers/home_provider.dart';
import 'package:mobile_plus/layout/widgets/custom_pull_to_refresh.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final userDataAsync = ref.watch(userDataProvider);

    return Scaffold(
      appBar: AppBar(
        // title: const Text('Home Page'),
      ),
      body: userDataAsync.when(
        data: (userData) => CustomPullToRefresh(
          onRefresh: () async {
            // Refresh the user data
            ref.invalidate(userDataProvider);
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            children: [
              const Center(child: Text('Home Page')),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${userData.id}'),
                      const SizedBox(height: 8),
                      Text('Name: ${userData.name}'),
                      const SizedBox(height: 8),
                      Text('Email: ${userData.email}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // push so back returns to home instead of closing the app
                  context.push('/social/home');
                },
                child: const Text('Go Social'),
              ),
            ],
          ),
        ),
        loading: () => const HomePageShimmerLoading(),
        error: (error, stackTrace) => CustomPullToRefresh(
          onRefresh: () async {
            ref.invalidate(userDataProvider);
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.invalidate(userDataProvider);
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}