import 'package:flutter/material.dart';
import 'package:mobile_plus/layout/splash_screen.dart';

/// A lightweight pull-to-refresh implementation that does NOT show
/// the default RefreshIndicator UI. Instead it listens for overscroll
/// at the top and triggers [onRefresh] while showing the app's
/// custom splash overlay.
class CustomPullToRefresh extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final double triggerDistance;

  const CustomPullToRefresh({
    Key? key,
    required this.child,
    required this.onRefresh,
    this.triggerDistance = 80,
  }) : super(key: key);

  @override
  State<CustomPullToRefresh> createState() => _CustomPullToRefreshState();
}

class _CustomPullToRefreshState extends State<CustomPullToRefresh> {
  double _dragOffset = 0.0;
  bool _refreshing = false;

  bool _onScrollNotification(ScrollNotification n) {
    if (n is OverscrollNotification && n.metrics.axis == Axis.vertical) {
      if (n.overscroll < 0 && n.metrics.pixels <= 0) {
        _dragOffset += -n.overscroll;
        if (!_refreshing && _dragOffset >= widget.triggerDistance) {
          _triggerRefresh();
        }
      }
    }

    if (n is ScrollEndNotification || n is ScrollUpdateNotification && n.metrics.pixels > 0) {
      // reset when touch ends or scroll moves away from top
      _dragOffset = 0.0;
    }

    return false; // allow other listeners to handle notifications
  }

  Future<void> _triggerRefresh() async {
    setState(() => _refreshing = true);
    await showSplashOverlay(context);
    try {
      await widget.onRefresh();
    } finally {
      if (mounted) setState(() => _refreshing = false);
      _dragOffset = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: widget.child,
    );
  }
}
