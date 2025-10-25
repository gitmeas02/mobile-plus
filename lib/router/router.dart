import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_plus/features/introduction/presentation/page/introduction_page.dart';
import 'package:mobile_plus/layout/one_time_screen.dart';
import 'package:mobile_plus/layout/splash_screen.dart';
import 'package:mobile_plus/router/home_routes.dart';
import 'package:mobile_plus/router/social_routes.dart';
final routerKeyProvider = Provider((_) => GlobalKey<NavigatorState>());

final goRouterProvider= Provider<GoRouter>((ref){
  final navigationKey = ref.watch(routerKeyProvider);
  return GoRouter(
    navigatorKey: navigationKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
  GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
  GoRoute(path: '/welcome', builder: (context, state) => const OneTimeScreen()),
  GoRoute(name: 'introduction',path: '/introduction',builder: (context, state) => const IntroductionPage(),
      ),
      ...homeRoutes,
      ...socialRoutes,
    ],
    redirect: (context,state){
      // No global redirect for now.
      return null;
    }
  );
}

);
  const publicRoutePaths = {
    '/login',
    '/register',
    '/introduction',
    '/choose-account',
    '/remove-account',
    '/verify-otp',
    '/set-pin',
  };