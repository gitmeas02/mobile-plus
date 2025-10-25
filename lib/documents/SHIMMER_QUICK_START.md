# Shimmer Loading - Quick Start Guide

## What's Been Implemented

✅ **Base Shimmer Components** (`shimmer_widgets.dart`)
- ShimmerWrapper, ShimmerBox, ShimmerCircle, ShimmerTextLine
- ShimmerCard, ShimmerListItem, ShimmerGridItem, ShimmerImage

✅ **Page-Specific Loading States** (`shimmer_loading_states.dart`)
- HomePageShimmerLoading
- SocialPageShimmerLoading
- IntroductionPageShimmerLoading
- ListShimmerLoading (generic)
- GridShimmerLoading (generic)

✅ **Updated Pages with Shimmer**
- ✅ HomePage - Shows shimmer for 2 seconds on load
- ✅ SocialPage - Shows shimmer for 2 seconds on load
- ✅ IntroductionPage - Shows shimmer for 2 seconds on load

✅ **Updated NotificationCard Widget**
- Enhanced with proper shimmer loading state
- Better styling and icons

✅ **Demo & Documentation**
- ShimmerDemoPage - Interactive showcase of all components
- Comprehensive documentation

## How to Use

### 1. In Your Pages (Already Done)

```dart
class YourPage extends ConsumerStatefulWidget {
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
    setState(() => _isLoading = true);
    // Your data loading logic
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const YourPageShimmerLoading()
          : YourActualContent(),
    );
  }
}
```

### 2. Test the Demo Page

Add to your router or navigate directly:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ShimmerDemoPage(),
  ),
);
```

### 3. Create Custom Shimmer

```dart
import 'package:mobile_plus/core/widgets/shimmer_widgets.dart';

ShimmerWrapper(
  child: Column(
    children: [
      Row(
        children: [
          const ShimmerCircle(size: 48),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: const [
                ShimmerTextLine(width: 150, height: 16),
                SizedBox(height: 8),
                ShimmerTextLine(width: double.infinity, height: 14),
              ],
            ),
          ),
        ],
      ),
    ],
  ),
)
```

## What You Get

### ✨ Professional Loading States
- Smooth shimmer animations
- Consistent styling across the app
- Better user experience during data loading

### 🎨 Customizable Components
- Adjust colors, sizes, and shapes
- Create custom layouts easily
- Match your app's design system

### 📱 Responsive Design
- Works on all screen sizes
- Uses MediaQuery for dynamic sizing
- Proper spacing and margins

### ⚡ Performance Optimized
- Efficient rendering
- Minimal re-renders
- Lightweight animations

## Next Steps

1. **Adjust Loading Duration**: Change the `Duration(seconds: 2)` in each page to match your actual API response times.

2. **Connect to Real Data**: Replace the simulated loading with actual API calls or data fetching logic.

3. **Customize Colors**: Update shimmer colors to match your theme:
   ```dart
   ShimmerWrapper(
     baseColor: Colors.grey[300],
     highlightColor: Colors.grey[100],
     child: YourWidget(),
   )
   ```

4. **Add More Pages**: Use the same pattern for any new pages you create.

5. **Error States**: Consider adding error states alongside loading states.

## Files Modified

- ✅ `lib/features/home/presentation/page/home_page.dart`
- ✅ `lib/features/social/presentation/page/social_page.dart`
- ✅ `lib/features/introduction/presentation/page/introduction_page.dart`
- ✅ `lib/features/introduction/presentation/widgets/notification_card.dart`

## Files Created

- ✅ `lib/core/widgets/shimmer_widgets.dart`
- ✅ `lib/core/widgets/shimmer_loading_states.dart`
- ✅ `lib/core/widgets/shimmer_demo_page.dart`
- ✅ `lib/core/widgets/SHIMMER_README.md`

## Need Help?

Check the full documentation in `lib/core/widgets/SHIMMER_README.md` for:
- Detailed API reference
- Advanced usage examples
- Best practices
- Troubleshooting guide
