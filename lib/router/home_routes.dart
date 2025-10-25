import 'package:go_router/go_router.dart';
import 'package:mobile_plus/features/home/presentation/page/home_page.dart';

final homeRoutes=[
  GoRoute(path: '/home',
  name:'home',
  builder: (_, __) => const HomePage()),
];