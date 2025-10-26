import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_plus/core/widgets/shimmer_loading_states.dart';
import 'package:mobile_plus/layout/widgets/custom_pull_to_refresh.dart';
import 'package:mobile_plus/layout/widgets/login_button_widget.dart';

class SocialPage extends ConsumerStatefulWidget {
  const SocialPage({super.key});

  @override
  ConsumerState<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends ConsumerState<SocialPage> {
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
        automaticallyImplyLeading: false,
        title: const Text('Social'),
      ),
      body: _isLoading
          ? const SocialPageShimmerLoading()
          : CustomPullToRefresh(
              onRefresh: () async {
                await _loadData();
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text('Social Page'),
                  TextButton(
                    onPressed: () {
                      context.push('/introduction');
                    },
                    child: const Text('Social Action'),
                  ),
                  LoginButtonWidget(
                    onPressed: () {},
                    text: 'Login',
                    link: 'https://example.com/login',
                    image: 'https://random-d.uk/api/219.jpg',
                  )
                ],
              ),
            ),
    );
  }
}