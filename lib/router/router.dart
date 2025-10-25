import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_plus/features/introduction/presentation/page/introduction_page.dart';
import 'package:mobile_plus/layout/splash_screen.dart';
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
        GoRoute(
        name: 'introduction',
        path: '/introduction',
        builder: (context, state) => const IntroductionPage(),
      ),
      ...socialRoutes,
    ],
    redirect: (context,state){

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