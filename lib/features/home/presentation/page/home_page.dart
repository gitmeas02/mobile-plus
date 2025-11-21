import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_plus/features/home/data/providers/home_provider.dart';
import 'package:mobile_plus/features/home/presentation/widgets/animated_avatar_widget.dart';
import 'package:mobile_plus/layout/widgets/custom_pull_to_refresh.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final userDataList = ref.watch(allUsersProvider);

    return Scaffold(
      appBar: AppBar(
        title:  AnimatedAvatarWidget(
                name: 'Mobile Plus',
                imageUrl:'https://i.pravatar.cc/150?img=67',
                size: 44,
                borderWidth: 4,
                borderColor: Colors.green,
                arcLength: 0.5,
                showShadow: true,
        )
        ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              context.push('/login');
            },
            child: const Text('Go to Login'),
          ),
        ),
      ),
      body: userDataList.when(
        data: (userData) => CustomPullToRefresh(
          onRefresh: () async {
            ref.invalidate(allUsersProvider);
            // Wait for the provider to finish reloading
            await ref.read(allUsersProvider.future);
            
          },
          child: ListView.separated(
            itemCount: userData.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final user = userData[index];
              return _SwipeableUserTile(user: user);
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => CustomPullToRefresh(
          onRefresh: () async {
            ref.invalidate(allUsersProvider);
            await ref.read(allUsersProvider.future);
          },
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.4),
              Center(child: Text('Error: $e')),
            ],
          ),
        ),
      ),
    );
  }
}

class _SwipeableUserTile extends StatefulWidget {
  final dynamic user; // replace with your User model

  const _SwipeableUserTile({super.key, required this.user});

  @override
  State<_SwipeableUserTile> createState() => _SwipeableUserTileState();
}

class _SwipeableUserTileState extends State<_SwipeableUserTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _starController;
  late Animation<double> _starAnimation;
  bool _deleted = false;

  @override
  void initState() {
    super.initState();
    _starController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _starAnimation = CurvedAnimation(parent: _starController, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _starController.dispose();
    super.dispose();
  }

  void _triggerStarAnimation() {
    _starController.forward(from: 0);
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() => _deleted = true); // remove the item after animation
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_deleted) return const SizedBox.shrink();

    return Dismissible(
      key: Key(widget.user.id.toString()),
      direction: DismissDirection.horizontal,
      background: Container(
        color: Colors.blue,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.person, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Swipe right → view profile
          context.go('/user/${widget.user.id}');
          return false; // don't remove
        } else {
          // Swipe left → delete with star animation
          _triggerStarAnimation();
          return false; // handled manually
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _starController.isAnimating ? 0.0 : 1.0,
            child: ListTile(
              tileColor: Colors.white,
              leading: AnimatedAvatarWidget(
                name: widget.user.username,
                imageUrl: 'https://i.pravatar.cc/150?img=3',
                size: 44,
                borderWidth: 4,
                borderColor: Colors.green,
                arcLength: 0.5,
                showShadow: true,
              ),
              title: Text(widget.user.username),
              subtitle: Text(widget.user.email),
            ),
          ),
          // Star burst animation
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _starAnimation,
              builder: (_, __) {
                final progress = _starAnimation.value;
                return CustomPaint(
                  painter: _StarPainter(progress: progress, color: Colors.yellow),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StarPainter extends CustomPainter {
  final double progress; // 0 → 1
  final Color color;

  _StarPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = color.withOpacity(1 - progress)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final numStars = 5;
    final maxRadius = size.width / 2;

    for (int i = 0; i < numStars; i++) {
      final angle = 2 * pi * i / numStars;
      final radius = maxRadius * progress;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      canvas.drawLine(center, Offset(x, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarPainter oldDelegate) => oldDelegate.progress != progress;
}
