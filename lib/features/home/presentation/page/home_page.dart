import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_plus/core/widgets/shimmer_loading_states.dart';
import 'package:mobile_plus/widgets/custom_pull_to_refresh.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    
    // Simulate loading data (replace with actual data loading)
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Home Page'),
      ),
      body: _isLoading
          ? const HomePageShimmerLoading()
          : CustomPullToRefresh(
              onRefresh: () async {
                await _loadData();
              },
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                children: [
                  const Center(child: Text('Home Page')),
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
    );
  }
}