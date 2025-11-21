import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedAvatarWidget extends ConsumerStatefulWidget {
  final String? name;
  final String? imageUrl;
  final double size;
  final double borderWidth;
  final Color borderColor;
  final double arcLength;   // % of border shown (0.0 → 1.0)
  final bool showShadow;

  const AnimatedAvatarWidget({
    super.key,
    this.name,
    this.imageUrl,
    this.size = 60,
    this.borderWidth = 4,
    this.borderColor = Colors.blue,
    this.arcLength = 0.35,
    this.showShadow = true,
  });

  @override
  ConsumerState<AnimatedAvatarWidget> createState() => _AnimatedAvatarWidgetState();
}

class _AnimatedAvatarWidgetState extends ConsumerState<AnimatedAvatarWidget>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fallbackText =
        (widget.name != null && widget.name!.isNotEmpty) ? widget.name![0] : '?';

    final hasImage = widget.imageUrl != null && widget.imageUrl!.isNotEmpty;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Avatar with Shadow
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: widget.showShadow
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      )
                    ]
                  : null,
            ),
            child: ClipOval(
              child: hasImage
                  ? Image.network(
                      widget.imageUrl!,
                      width: widget.size,
                      height: widget.size,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildFallback(fallbackText),
                    )
                  : _buildFallback(fallbackText),
            ),
          ),

          // Rotating Arc Border
          AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return Transform.rotate(
                angle: _controller.value * 2 * pi,
                child: CustomPaint(
                  size: Size(widget.size, widget.size),
                  painter: ArcBorderPainter(
                    strokeWidth: widget.borderWidth,
                    arcLength: widget.arcLength,
                    colors: [
                      widget.borderColor,
                      widget.borderColor.withOpacity(0.3),
                      widget.borderColor,
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFallback(String text) {
    return Container(
      color: Colors.grey.shade300,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: widget.size * 0.4,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class ArcBorderPainter extends CustomPainter {
  final double strokeWidth;
  final double arcLength;
  final List<Color> colors;

  ArcBorderPainter({
    required this.strokeWidth,
    required this.arcLength,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: colors,
        startAngle: 0,
        endAngle: 2 * pi,
      ).createShader(rect);

    canvas.drawArc(
      rect,
      0,
      2 * pi * arcLength,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
