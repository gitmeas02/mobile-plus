import 'package:go_router/go_router.dart';
import 'package:mobile_plus/features/social/presentation/page/social_page.dart';

final socialRoutes=[
  GoRoute(path: '/social/home',
  name:'social_home',
  builder: (context, state) => const SocialPage()),
];