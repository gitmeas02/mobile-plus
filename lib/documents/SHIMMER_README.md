# Shimmer Loading Effect Documentation

This documentation explains how to use the shimmer loading effects implemented in the Mobile Plus application.

## Overview

The shimmer loading system provides a smooth, animated placeholder effect while content is being loaded. It consists of reusable widgets and pre-built page-specific loading states.

## Files Structure

```
lib/core/widgets/
├── shimmer_widgets.dart          # Base shimmer components
└── shimmer_loading_states.dart   # Page-specific loading states
```

## Base Shimmer Components

### 1. ShimmerWrapper
Wraps any widget with shimmer animation effect.

```dart
ShimmerWrapper(
  baseColor: Colors.grey[300],      // Optional: base shimmer color
  highlightColor: Colors.grey[100], // Optional: highlight shimmer color
  child: YourWidget(),
)
```

### 2. ShimmerBox
Creates a rectangular shimmer placeholder.

```dart
ShimmerBox(
  width: 200,
  height: 100,
  borderRadius: 8,                  // Optional: corner radius
  margin: EdgeInsets.all(8),        // Optional: margin
)
```

### 3. ShimmerCircle
Creates a circular shimmer placeholder (ideal for avatars).

```dart
ShimmerCircle(
  size: 48,
  margin: EdgeInsets.all(8),        // Optional: margin
)
```

### 4. ShimmerTextLine
Creates a text line shimmer placeholder.

```dart
ShimmerTextLine(
  width: 150,                       // Optional: null = full width
  height: 16,
  margin: EdgeInsets.only(bottom: 8),
)
```

### 5. ShimmerCard
Creates a card-shaped shimmer placeholder.

```dart
ShimmerCard(
  width: double.infinity,           // Optional: null = full width
  height: 120,
  margin: EdgeInsets.all(16),       // Optional
  padding: EdgeInsets.all(16),      // Optional
)
```

### 6. ShimmerListItem
Creates a complete list item with leading avatar and text lines.

```dart
ShimmerListItem(
  hasLeading: true,                 // Show leading circle (avatar)
  hasTrailing: false,               // Show trailing widget
  margin: EdgeInsets.all(8),
)
```

### 7. ShimmerGridItem
Creates a grid item shimmer placeholder.

```dart
ShimmerGridItem(
  aspectRatio: 1.0,                 // Width/height ratio
)
```

### 8. ShimmerImage
Creates an image placeholder with shimmer.

```dart
ShimmerImage(
  width: double.infinity,           // Optional
  height: 200,                      // Optional: defaults to 200
  borderRadius: 8,
  margin: EdgeInsets.all(8),
)
```

## Page-Specific Loading States

### 1. HomePageShimmerLoading
Pre-built shimmer loading for the home page.

```dart
body: _isLoading
    ? const HomePageShimmerLoading()
    : YourActualContent(),
```

### 2. SocialPageShimmerLoading
Pre-built shimmer loading for the social page with post-like structures.

```dart
body: _isLoading
    ? const SocialPageShimmerLoading()
    : YourActualContent(),
```

### 3. IntroductionPageShimmerLoading
Pre-built shimmer loading for the introduction/notifications page.

```dart
body: _isLoading
    ? const IntroductionPageShimmerLoading()
    : YourActualContent(),
```

### 4. ListShimmerLoading
Generic list loading state with customizable options.

```dart
ListShimmerLoading(
  itemCount: 10,                    // Number of items to show
  hasLeading: true,                 // Show leading avatars
  hasTrailing: false,               // Show trailing widgets
)
```

### 5. GridShimmerLoading
Generic grid loading state.

```dart
GridShimmerLoading(
  crossAxisCount: 2,                // Number of columns
  aspectRatio: 1.0,                 // Item aspect ratio
  itemCount: 6,                     // Number of items
)
```

## Implementation Guide

### Step 1: Add Loading State to Your Page

```dart
class YourPage extends ConsumerStatefulWidget {
  const YourPage({super.key});

  @override
  ConsumerState<YourPage> createState() => _YourPageState();
}

class _YourPageState extends ConsumerState<YourPage> {
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
    
    // Load your actual data here
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
      appBar: AppBar(title: const Text('Your Page')),
      body: _isLoading
          ? const YourPageShimmerLoading()  // Show shimmer while loading
          : YourActualContent(),              // Show content when loaded
    );
  }
}
```

### Step 2: Create Custom Shimmer Loading (Optional)

If you need a custom shimmer loading state:

```dart
class CustomShimmerLoading extends StatelessWidget {
  const CustomShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header with avatar and text
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
                    ),
                    const SizedBox(height: 8),
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
          
          // Cards
          ...List.generate(
            5,
            (index) => const ShimmerCard(height: 150),
          ),
        ],
      ),
    );
  }
}
```

### Step 3: Use in Widgets

For individual widgets like NotificationCard:

```dart
class NotificationCard extends ConsumerWidget {
  const NotificationCard({
    super.key,
    required this.isLoading,
  });
  
  final bool isLoading;

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
        // Your shimmer design
        child: Row(
          children: [
            const ShimmerCircle(size: 48),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  const ShimmerTextLine(width: 150, height: 16),
                  const SizedBox(height: 8),
                  const ShimmerTextLine(width: double.infinity, height: 14),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentCard(BuildContext context) {
    // Your actual content
    return Container(/* ... */);
  }
}
```

## Best Practices

1. **Match Shimmer to Content Layout**: Ensure your shimmer placeholders closely match the actual content structure for a smoother transition.

2. **Appropriate Duration**: Keep loading times reasonable (1-3 seconds). If data takes longer, consider showing progress indicators.

3. **Consistent Styling**: Use the same border radius, spacing, and dimensions as your actual content.

4. **Don't Overuse**: Only use shimmer for initial page loads or significant data refreshes, not for every minor update.

5. **Accessibility**: Ensure the shimmer effect doesn't cause issues for users with motion sensitivity. Consider adding reduced motion support if needed.

6. **Color Customization**: Adjust base and highlight colors to match your app's theme:
```dart
ShimmerWrapper(
  baseColor: Theme.of(context).colorScheme.surfaceVariant,
  highlightColor: Theme.of(context).colorScheme.surface,
  child: YourWidget(),
)
```

## Examples in the App

- **HomePage**: Uses `HomePageShimmerLoading` with cards and buttons
- **SocialPage**: Uses `SocialPageShimmerLoading` with post-like structures
- **IntroductionPage**: Uses `IntroductionPageShimmerLoading` with notification cards
- **NotificationCard**: Individual widget-level shimmer implementation

## Troubleshooting

### Shimmer not showing
- Ensure you've imported: `import 'package:mobile_plus/core/widgets/shimmer_loading_states.dart';`
- Check that `_isLoading` state is properly managed
- Verify shimmer package is in `pubspec.yaml`

### Shimmer looks wrong
- Adjust dimensions to match your actual content
- Check responsive width calculations for different screen sizes
- Ensure proper constraints on parent widgets

### Performance issues
- Reduce the number of shimmer items shown at once
- Simplify complex shimmer layouts
- Use `RepaintBoundary` if needed for optimization

## Future Enhancements

Consider adding:
- Dark mode shimmer colors
- Animated skeleton screens with different animation speeds
- Shimmer presets for common UI patterns
- A11y improvements for reduced motion preferences
