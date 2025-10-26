import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_plus/core/widgets/shimmer_loading_states.dart';
import 'package:mobile_plus/features/introduction/presentation/widgets/notification_card.dart';
import 'package:mobile_plus/layout/widgets/custom_pull_to_refresh.dart';

class IntroductionPage extends ConsumerStatefulWidget {
  const IntroductionPage({super.key});

  @override
  ConsumerState<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends ConsumerState<IntroductionPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              context.pop();
            },
          ),
        ],
      ),
      body: _isLoading
          ? const IntroductionPageShimmerLoading()
          : CustomPullToRefresh(
              onRefresh: () async {
                await _loadData();
              },
              child: ListView(
                children: [
                  const Center(
                    child: Text(
                      'Introduction Page',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Multiple notification cards
                  NotificationCard(
                    isLoading: false,
                    title: 'Welcome to Mobile Plus',
                    message: 'This is your introduction notification.',
                    icon: Icons.celebration,
                    time: '2 hours ago',
                  ),
                  NotificationCard(
                    isLoading: false,
                    title: 'New Feature Available',
                    message: 'Check out our latest updates and improvements.',
                    icon: Icons.new_releases,
                    time: '5 hours ago',
                  ),
                  NotificationCard(
                    isLoading: false,
                    title: 'System Update',
                    message: 'Your app has been updated to the latest version.',
                    icon: Icons.system_update,
                    time: '1 day ago',
                  ),
                ],
              ),
            ),
    );
  }
}