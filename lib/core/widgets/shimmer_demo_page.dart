import 'package:flutter/material.dart';
import 'package:mobile_plus/core/widgets/shimmer_loading_states.dart';
import 'package:mobile_plus/core/widgets/shimmer_widgets.dart';

/// Demo page to showcase all shimmer loading components
class ShimmerDemoPage extends StatefulWidget {
  const ShimmerDemoPage({super.key});

  @override
  State<ShimmerDemoPage> createState() => _ShimmerDemoPageState();
}

class _ShimmerDemoPageState extends State<ShimmerDemoPage> {
  int _selectedIndex = 0;

  final List<String> _demos = [
    'Basic Components',
    'List Loading',
    'Grid Loading',
    'Home Page',
    'Social Page',
    'Introduction Page',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Demo'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: _demos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(_demos[index]),
                    selected: _selectedIndex == index,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: _buildSelectedDemo(),
    );
  }

  Widget _buildSelectedDemo() {
    switch (_selectedIndex) {
      case 0:
        return _buildBasicComponents();
      case 1:
        return const ListShimmerLoading();
      case 2:
        return const GridShimmerLoading();
      case 3:
        return const HomePageShimmerLoading();
      case 4:
        return const SocialPageShimmerLoading();
      case 5:
        return const IntroductionPageShimmerLoading();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBasicComponents() {
    return ShimmerWrapper(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            'Shimmer Box',
            'Rectangular placeholders with customizable size',
            const ShimmerBox(
              width: double.infinity,
              height: 100,
              borderRadius: 12,
            ),
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Shimmer Circle',
            'Circular placeholders perfect for avatars',
            Row(
              children: const [
                ShimmerCircle(size: 40),
                SizedBox(width: 12),
                ShimmerCircle(size: 56),
                SizedBox(width: 12),
                ShimmerCircle(size: 72),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Shimmer Text Lines',
            'Text placeholders with varying widths',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerTextLine(
                  width: double.infinity,
                  height: 18,
                  margin: EdgeInsets.only(bottom: 8),
                ),
                ShimmerTextLine(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 16,
                  margin: const EdgeInsets.only(bottom: 8),
                ),
                ShimmerTextLine(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 14,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Shimmer Card',
            'Complete card structure',
            const ShimmerCard(
              height: 150,
              margin: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Shimmer List Item',
            'Pre-built list item with avatar and text',
            const ShimmerListItem(
              hasLeading: true,
              hasTrailing: true,
              margin: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Shimmer Image',
            'Image placeholder',
            const ShimmerImage(
              height: 200,
              borderRadius: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String description, Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
