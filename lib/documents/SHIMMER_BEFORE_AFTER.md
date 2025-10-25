# Shimmer Loading - Before & After Examples

## 📱 HomePage

### Before (No Shimmer)
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(),
    body: CustomPullToRefresh(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 300));
      },
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        children: [
          const Center(child: Text('Home Page')),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => context.push('/social/home'),
            child: const Text('Go Social'),
          ),
        ],
      ),
    ),
  );
}
```

### After (With Shimmer) ✅
```dart
class _HomePageState extends ConsumerState<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // Simulate loading
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? const HomePageShimmerLoading()  // ✨ Shimmer while loading
          : CustomPullToRefresh(
              onRefresh: () async => await _loadData(),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                children: [
                  const Center(child: Text('Home Page')),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.push('/social/home'),
                    child: const Text('Go Social'),
                  ),
                ],
              ),
            ),
    );
  }
}
```

**What Changed:**
- ✅ Added `_isLoading` state
- ✅ Added `_loadData()` method
- ✅ Conditional rendering with `HomePageShimmerLoading`
- ✅ Pull-to-refresh triggers shimmer

---

## 📱 SocialPage

### Before (No Shimmer)
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Social'),
    ),
    body: CustomPullToRefresh(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 300));
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Social Page'),
          TextButton(
            onPressed: () => context.push('/introduction'),
            child: Text('Social Action'),
          ),
        ],
      ),
    ),
  );
}
```

### After (With Shimmer) ✅
```dart
class _SocialPageState extends ConsumerState<SocialPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Social'),
      ),
      body: _isLoading
          ? const SocialPageShimmerLoading()  // ✨ Post-like shimmer
          : CustomPullToRefresh(
              onRefresh: () async => await _loadData(),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text('Social Page'),
                  TextButton(
                    onPressed: () => context.push('/introduction'),
                    child: const Text('Social Action'),
                  ),
                ],
              ),
            ),
    );
  }
}
```

**What Changed:**
- ✅ Added loading state management
- ✅ Shows post-like shimmer structures
- ✅ Smooth loading experience

---

## 📱 IntroductionPage

### Before (No Shimmer)
```dart
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
          onPressed: () => context.pop(),
        ),
      ],
    ),
    body: CustomPullToRefresh(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 300));
      },
      child: ListView(
        children: [
          const Center(
            child: Text('Introduction Page', style: TextStyle(fontSize: 24)),
          ),
          NotificationCard(isLoading: false),
        ],
      ),
    ),
  );
}
```

### After (With Shimmer) ✅
```dart
class _IntroductionPageState extends ConsumerState<IntroductionPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isLoading = false);
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
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: _isLoading
          ? const IntroductionPageShimmerLoading()  // ✨ Notification shimmer
          : CustomPullToRefresh(
              onRefresh: () async => await _loadData(),
              child: ListView(
                children: [
                  const Center(
                    child: Text(
                      'Introduction Page',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                    message: 'Check out our latest updates.',
                    icon: Icons.new_releases,
                    time: '5 hours ago',
                  ),
                ],
              ),
            ),
    );
  }
}
```

**What Changed:**
- ✅ Added shimmer loading state
- ✅ Enhanced NotificationCard with more props
- ✅ Multiple notification cards
- ✅ Better visual presentation

---

## 🎨 NotificationCard Widget

### Before (Basic Shimmer)
```dart
class NotificationCard extends ConsumerWidget {
  const NotificationCard({super.key, required this.isLoading});
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildText(),
          const SizedBox(width: 12),
          _buildText(),
        ],
      ),
    );
  }

  Widget _buildText() {
    if (isLoading) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 16,
              color: Colors.grey.shade300,  // ❌ Static gray boxes
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 16,
              color: Colors.grey.shade300,
            ),
          ],
        ),
      );
    } else {
      return const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Mobile Plus',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'This is your introduction notification.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      );
    }
  }
}
```

### After (Enhanced with Proper Shimmer) ✅
```dart
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
    return ShimmerWrapper(  // ✨ Animated shimmer wrapper
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
            const ShimmerCircle(size: 48),  // ✨ Animated circle
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerTextLine(  // ✨ Animated text lines
                    width: 150,
                    height: 16,
                    margin: EdgeInsets.only(bottom: 8),
                  ),
                  ShimmerTextLine(
                    width: double.infinity,
                    height: 14,
                    margin: EdgeInsets.only(bottom: 4),
                  ),
                  ShimmerTextLine(
                    width: 200,
                    height: 14,
                    margin: EdgeInsets.only(bottom: 8),
                  ),
                  ShimmerTextLine(
                    width: 80,
                    height: 12,
                    margin: EdgeInsets.only(top: 4),
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
```

**What Changed:**
- ✅ Animated shimmer instead of static gray boxes
- ✅ Better card structure and styling
- ✅ Added customizable props (title, message, icon, time)
- ✅ Professional shadows and rounded corners
- ✅ Proper icon display in content state

---

## 📊 Visual Comparison

### Static Gray Boxes (Before) ❌
```
┌────────────────────────────────┐
│  ████████████████              │  Static, boring
│  ████████████                  │  No animation
│                                │  Poor UX
└────────────────────────────────┘
```

### Animated Shimmer (After) ✅
```
┌────────────────────────────────┐
│  ░░▒▒▓▓████▓▓▒▒░░              │  Animated waves
│  ░░▒▒▓▓██▓▓▒▒░░                │  Professional look
│                                │  Great UX
└────────────────────────────────┘
     ↑  Animation direction →
```

---

## 🎯 Key Improvements

### User Experience
- **Before**: No loading feedback, sudden content appearance
- **After**: Smooth animated placeholders, clear loading state

### Visual Appeal
- **Before**: Static gray boxes, boring
- **After**: Animated shimmer effect, professional

### Code Quality
- **Before**: Inline styles, no reusability
- **After**: Reusable components, clean architecture

### Maintainability
- **Before**: Hard to modify, scattered code
- **After**: Centralized components, easy to customize

### Consistency
- **Before**: Different loading styles across pages
- **After**: Consistent shimmer pattern everywhere

---

## 🚀 Usage Pattern

### Standard Pattern for Any Page
```dart
// 1. Add state
bool _isLoading = true;

// 2. Load data
Future<void> _loadData() async {
  setState(() => _isLoading = true);
  // Your loading logic
  await fetchData();
  setState(() => _isLoading = false);
}

// 3. Render conditionally
body: _isLoading
    ? const YourPageShimmerLoading()
    : YourActualContent(),
```

This pattern is now implemented in:
- ✅ HomePage
- ✅ SocialPage
- ✅ IntroductionPage
- ✅ NotificationCard

Ready to use in future pages! 🎉
