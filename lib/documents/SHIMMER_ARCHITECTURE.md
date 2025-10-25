# Shimmer Loading System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     SHIMMER LOADING SYSTEM                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    1. BASE COMPONENTS LAYER                     │
│                   (shimmer_widgets.dart)                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ShimmerWrapper ─────────────────────────┐                     │
│       │                                    │                     │
│       ├─► Adds shimmer animation effect    │                     │
│       └─► Customizable colors             │                     │
│                                            │                     │
│  ┌──────────────────────────────────────┐ │                     │
│  │  ShimmerBox                          │ │                     │
│  │  • Rectangular shapes                │ │                     │
│  │  • Custom width/height               │ │                     │
│  │  • Border radius                     │ │                     │
│  └──────────────────────────────────────┘ │                     │
│                                            │                     │
│  ┌──────────────────────────────────────┐ │                     │
│  │  ShimmerCircle                       │ │                     │
│  │  • Circular shapes                   │ │                     │
│  │  • Perfect for avatars               │◄┼───── Wrapped in    │
│  └──────────────────────────────────────┘ │      ShimmerWrapper │
│                                            │                     │
│  ┌──────────────────────────────────────┐ │                     │
│  │  ShimmerTextLine                     │ │                     │
│  │  • Text placeholders                 │ │                     │
│  │  • Adjustable width                  │ │                     │
│  └──────────────────────────────────────┘ │                     │
│                                            │                     │
│  ┌──────────────────────────────────────┐ │                     │
│  │  ShimmerCard                         │ │                     │
│  │  • Card structures                   │ │                     │
│  │  • With padding/margin               │ │                     │
│  └──────────────────────────────────────┘ │                     │
│                                            │                     │
│  ┌──────────────────────────────────────┐ │                     │
│  │  ShimmerListItem                     │ │                     │
│  │  • Pre-built list items              │ │                     │
│  │  • Avatar + Text combo               │ │                     │
│  └──────────────────────────────────────┘ │                     │
│                                            │                     │
│  ┌──────────────────────────────────────┐ │                     │
│  │  ShimmerImage                        │ │                     │
│  │  • Image placeholders                │ │                     │
│  └──────────────────────────────────────┘ │                     │
│                                            │                     │
│  ┌──────────────────────────────────────┐ │                     │
│  │  ShimmerGridItem                     │ │                     │
│  │  • Grid item placeholders            │ │                     │
│  └──────────────────────────────────────┘─┘                     │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
                           │
                           │ Used by
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│               2. PAGE-SPECIFIC LOADING STATES LAYER             │
│                 (shimmer_loading_states.dart)                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │  HomePageShimmerLoading                                 │   │
│  │  • Uses: ShimmerTextLine, ShimmerCard, ShimmerBox      │   │
│  │  • Layout: Title + Cards + Button                       │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │  SocialPageShimmerLoading                               │   │
│  │  • Uses: ShimmerCircle, ShimmerTextLine, ShimmerImage  │   │
│  │  • Layout: Post-like structures with avatars           │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │  IntroductionPageShimmerLoading                         │   │
│  │  • Uses: ShimmerCircle, ShimmerTextLine                │   │
│  │  • Layout: Notification cards                           │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │  ListShimmerLoading                                     │   │
│  │  • Generic list loading                                 │   │
│  │  • Customizable item count                             │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │  GridShimmerLoading                                     │   │
│  │  • Generic grid loading                                 │   │
│  │  • Customizable columns & items                        │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
                           │
                           │ Used in
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                    3. APPLICATION PAGES LAYER                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌───────────────────────────────────────────────────────┐     │
│  │  HomePage                                             │     │
│  │  ┌─────────────────────────────────────────────────┐  │     │
│  │  │  State: _isLoading                              │  │     │
│  │  │  ┌──────────────────────────────────────────┐   │  │     │
│  │  │  │ if (_isLoading)                          │   │  │     │
│  │  │  │   → HomePageShimmerLoading()             │   │  │     │
│  │  │  │ else                                      │   │  │     │
│  │  │  │   → Actual Content                        │   │  │     │
│  │  │  └──────────────────────────────────────────┘   │  │     │
│  │  └─────────────────────────────────────────────────┘  │     │
│  └───────────────────────────────────────────────────────┘     │
│                                                                 │
│  ┌───────────────────────────────────────────────────────┐     │
│  │  SocialPage                                           │     │
│  │  ┌─────────────────────────────────────────────────┐  │     │
│  │  │  State: _isLoading                              │  │     │
│  │  │  ┌──────────────────────────────────────────┐   │  │     │
│  │  │  │ if (_isLoading)                          │   │  │     │
│  │  │  │   → SocialPageShimmerLoading()           │   │  │     │
│  │  │  │ else                                      │   │  │     │
│  │  │  │   → Actual Content                        │   │  │     │
│  │  │  └──────────────────────────────────────────┘   │  │     │
│  │  └─────────────────────────────────────────────────┘  │     │
│  └───────────────────────────────────────────────────────┘     │
│                                                                 │
│  ┌───────────────────────────────────────────────────────┐     │
│  │  IntroductionPage                                     │     │
│  │  ┌─────────────────────────────────────────────────┐  │     │
│  │  │  State: _isLoading                              │  │     │
│  │  │  ┌──────────────────────────────────────────┐   │  │     │
│  │  │  │ if (_isLoading)                          │   │  │     │
│  │  │  │   → IntroductionPageShimmerLoading()     │   │  │     │
│  │  │  │ else                                      │   │  │     │
│  │  │  │   → Actual Content with NotificationCard │   │  │     │
│  │  │  └──────────────────────────────────────────┘   │  │     │
│  │  └─────────────────────────────────────────────────┘  │     │
│  └───────────────────────────────────────────────────────┘     │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘


┌─────────────────────────────────────────────────────────────────┐
│                        4. WIDGET LEVEL                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌───────────────────────────────────────────────────────┐     │
│  │  NotificationCard                                     │     │
│  │  ┌─────────────────────────────────────────────────┐  │     │
│  │  │  Props: isLoading, title, message, icon, time  │  │     │
│  │  │  ┌──────────────────────────────────────────┐   │  │     │
│  │  │  │ if (isLoading)                           │   │  │     │
│  │  │  │   → _buildShimmerCard()                  │   │  │     │
│  │  │  │      (Uses ShimmerWrapper + components)  │   │  │     │
│  │  │  │ else                                      │   │  │     │
│  │  │  │   → _buildContentCard()                   │   │  │     │
│  │  │  └──────────────────────────────────────────┘   │  │     │
│  │  └─────────────────────────────────────────────────┘  │     │
│  └───────────────────────────────────────────────────────┘     │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘


═══════════════════════════════════════════════════════════════════
                         DATA FLOW
═══════════════════════════════════════════════════════════════════

1. Page Loads
   │
   ├─► initState() called
   │   └─► _loadData() triggered
   │       └─► setState(_isLoading = true)
   │
2. Shimmer Displayed
   │
   ├─► build() renders
   │   └─► if (_isLoading) → Shows ShimmerLoading widget
   │       └─► ShimmerLoading uses base components
   │           └─► ShimmerWrapper adds animation
   │
3. Data Loads (simulated 2 seconds)
   │
   ├─► Future.delayed(Duration(seconds: 2))
   │   └─► Data fetch/processing happens
   │
4. Content Displayed
   │
   └─► setState(_isLoading = false)
       └─► build() renders
           └─► if (!_isLoading) → Shows actual content


═══════════════════════════════════════════════════════════════════
                      CUSTOMIZATION POINTS
═══════════════════════════════════════════════════════════════════

1. Colors
   │
   └─► ShimmerWrapper(
       │   baseColor: Colors.grey[300],
       │   highlightColor: Colors.grey[100],
       └─► )

2. Duration
   │
   └─► await Future.delayed(
       │   const Duration(seconds: 2), // Change this
       └─► )

3. Layout
   │
   └─► Create custom loading state using base components

4. Components
   │
   └─► Mix and match ShimmerBox, ShimmerCircle, etc.


═══════════════════════════════════════════════════════════════════
```

## Usage Flow

```dart
// Step 1: Import
import 'package:mobile_plus/core/widgets/shimmer_loading_states.dart';

// Step 2: Add state
bool _isLoading = true;

// Step 3: Load data
Future<void> _loadData() async {
  setState(() => _isLoading = true);
  await fetchYourData();
  setState(() => _isLoading = false);
}

// Step 4: Use in build
body: _isLoading
    ? const YourPageShimmerLoading()  // Shimmer
    : YourActualContent(),              // Content
```

## Component Hierarchy

```
ShimmerWrapper
├── ShimmerBox
├── ShimmerCircle
├── ShimmerTextLine
├── ShimmerCard
├── ShimmerListItem
│   ├── ShimmerCircle (avatar)
│   └── ShimmerTextLine (text)
├── ShimmerGridItem
└── ShimmerImage
```

## Page Loading States Composition

### HomePageShimmerLoading
```
ShimmerWrapper
└── ListView
    ├── ShimmerTextLine (title)
    ├── ShimmerCard × 5
    └── ShimmerBox (button)
```

### SocialPageShimmerLoading
```
ShimmerWrapper
└── ListView
    ├── Row (header)
    │   ├── ShimmerCircle
    │   └── ShimmerTextLine × 2
    └── Posts × 3
        ├── Row (post header)
        │   ├── ShimmerCircle
        │   └── ShimmerTextLine × 2
        ├── ShimmerTextLine × 2 (content)
        ├── ShimmerImage
        └── ShimmerBox × 3 (actions)
```

### IntroductionPageShimmerLoading
```
ShimmerWrapper
└── ListView
    ├── ShimmerTextLine (title)
    └── Notification Cards × 4
        ├── ShimmerCircle
        └── ShimmerTextLine × 3
```
