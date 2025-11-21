import 'package:go_router/go_router.dart';
import 'package:mobile_plus/features/login/page/presentation/login_page.dart';

final authRoutes = [
 GoRoute(
  path: '/login',
  name: 'login',
  builder: (context, state) {
    return LoginPage(
      onLoginSuccess: () {
        // Handle login success - navigate to home
        context.go('/home');
      },
      onBack: () {
        // Just pop since we're using push navigation
        context.pop();
      },
    );
  }),
];