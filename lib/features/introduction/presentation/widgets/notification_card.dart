import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_plus/core/widgets/shimmer_widgets.dart';

class NotificationCard extends ConsumerWidget {
  const NotificationCard({
    super.key,
    required this.isLoading,
    this.title,
    this.message,
    this.icon,
    this.time,
  });
  
  final bool isLoading;
  final String? title;
  final String? message;
  final IconData? icon;
  final String? time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isLoading) {
      return _buildShimmerCard();
    }
    return _buildContentCard(context);
  }

  Widget _buildShimmerCard() {
    return ShimmerWrapper(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerCircle(size: 48),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerTextLine(
                    width: 150,
                    height: 16,
                    margin: EdgeInsets.only(bottom: 8),
                  ),
                  const ShimmerTextLine(
                    width: double.infinity,
                    height: 14,
                    margin: EdgeInsets.only(bottom: 4),
                  ),
                  const ShimmerTextLine(
                    width: 200,
                    height: 14,
                    margin: EdgeInsets.only(bottom: 8),
                  ),
                  ShimmerTextLine(
                    width: 80,
                    height: 12,
                    margin: const EdgeInsets.only(top: 4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon ?? Icons.notifications,
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? 'Welcome to Mobile Plus',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message ?? 'This is your introduction notification.',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                if (time != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    time!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
