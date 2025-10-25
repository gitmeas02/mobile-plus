import 'package:flutter/material.dart';
import 'package:mobile_plus/core/widgets/shimmer_widgets.dart';

/// Home Page Shimmer Loading
class HomePageShimmerLoading extends StatelessWidget {
  const HomePageShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        children: [
          // Title placeholder
          ShimmerTextLine(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 24,
            margin: const EdgeInsets.only(bottom: 24),
          ),
          
          // Card placeholders
          ...List.generate(
            5,
            (index) => ShimmerCard(
              height: 120,
              margin: const EdgeInsets.only(bottom: 16),
            ),
          ),
          
          // Button placeholder
          ShimmerBox(
            width: double.infinity,
            height: 48,
            borderRadius: 8,
            margin: const EdgeInsets.only(top: 8),
          ),
        ],
      ),
    );
  }
}

/// Social Page Shimmer Loading
class SocialPageShimmerLoading extends StatelessWidget {
  const SocialPageShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header placeholder
          Row(
            children: [
              const ShimmerCircle(size: 56),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerTextLine(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 18,
                      margin: const EdgeInsets.only(bottom: 8),
                    ),
                    ShimmerTextLine(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Post/Content placeholders
          ...List.generate(
            3,
            (index) => Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Post header
                  Row(
                    children: [
                      const ShimmerCircle(size: 40),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerTextLine(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 14,
                              margin: const EdgeInsets.only(bottom: 6),
                            ),
                            ShimmerTextLine(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Post content
                  const ShimmerTextLine(
                    width: double.infinity,
                    height: 14,
                    margin: EdgeInsets.only(bottom: 6),
                  ),
                  ShimmerTextLine(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 14,
                    margin: const EdgeInsets.only(bottom: 12),
                  ),
                  
                  // Post image
                  const ShimmerImage(
                    height: 200,
                    borderRadius: 12,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Action buttons
                  Row(
                    children: [
                      const ShimmerBox(width: 60, height: 32, borderRadius: 16),
                      const SizedBox(width: 12),
                      const ShimmerBox(width: 60, height: 32, borderRadius: 16),
                      const SizedBox(width: 12),
                      const ShimmerBox(width: 60, height: 32, borderRadius: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Introduction Page Shimmer Loading
class IntroductionPageShimmerLoading extends StatelessWidget {
  const IntroductionPageShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Title placeholder
          Center(
            child: ShimmerTextLine(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 28,
              margin: const EdgeInsets.only(bottom: 24),
            ),
          ),
          
          // Notification cards
          ...List.generate(
            4,
            (index) => Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
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
                        ShimmerTextLine(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 16,
                          margin: const EdgeInsets.only(bottom: 8),
                        ),
                        const ShimmerTextLine(
                          width: double.infinity,
                          height: 14,
                          margin: EdgeInsets.only(bottom: 4),
                        ),
                        ShimmerTextLine(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Generic List Shimmer Loading
class ListShimmerLoading extends StatelessWidget {
  final int itemCount;
  final bool hasLeading;
  final bool hasTrailing;

  const ListShimmerLoading({
    super.key,
    this.itemCount = 10,
    this.hasLeading = true,
    this.hasTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return ShimmerListItem(
            hasLeading: hasLeading,
            hasTrailing: hasTrailing,
          );
        },
      ),
    );
  }
}

/// Generic Grid Shimmer Loading
class GridShimmerLoading extends StatelessWidget {
  final int crossAxisCount;
  final double aspectRatio;
  final int itemCount;

  const GridShimmerLoading({
    super.key,
    this.crossAxisCount = 2,
    this.aspectRatio = 1.0,
    this.itemCount = 6,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: aspectRatio,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return ShimmerGridItem(aspectRatio: aspectRatio);
        },
      ),
    );
  }
}
