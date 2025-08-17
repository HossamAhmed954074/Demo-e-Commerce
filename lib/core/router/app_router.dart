import 'package:demo_ecommerce/core/services/auth_service.dart';
import 'package:demo_ecommerce/core/utils/git_it.dart';
import 'package:demo_ecommerce/features/auth/controller/cubit/auth_cubit.dart';
import 'package:demo_ecommerce/features/auth/view/screens/login_screen.dart';
import 'package:demo_ecommerce/features/auth/view/screens/register_screen.dart';
import 'package:demo_ecommerce/features/bottom_nav/bottom_nav.dart';
import 'package:demo_ecommerce/features/onboarding/view/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// AppRouter manages all app routes using GoRouter.
class AppRouter {
  // Route paths
  static const String onBoarding = '/';
  static const String logIn = '/login';
  static const String signUp = '/signUp';
  static const String bottomNav = '/bottomNav';

  // Route names for deep linking and navigation
  static const String onBoardingName = 'onboarding';
  static const String logInName = 'login';
  static const String signUpName = 'signup';
  static const String bottomNavName = 'bottomNav';

  // Singleton instance
  static final AppRouter _instance = AppRouter._internal();
  factory AppRouter() => _instance;
  AppRouter._internal();

  // The GoRouter instance
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: onBoarding,
        name: onBoardingName,
        builder: (context, state) {
          return FutureBuilder<bool>(
            future: SharedPreferences.getInstance().then(
              (prefs) => prefs.getBool('onboarding_completed') ?? false,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox.shrink();
              }
              if (snapshot.data == true) {
                if (AuthService().isLoggedIn) {
                  return const BottomNav();
                }
                return BlocProvider(
                  create: (context) => getIt<AuthCubit>(),
                  child: const LoginScreen(),
                );
              }
              return const OnboardingPage();
            },
          );
        },
      ),
      GoRoute(
        path: logIn,
        name: logInName,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: signUp,
        name: signUpName,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: RegisterScreen(),
        ),
      ),
      GoRoute(
        path: bottomNav,
        name: bottomNavName,
        builder: (context, state) => BottomNav(),
      ),
    ],
    // Error page handler (optional, for future extensibility)
    errorBuilder: (context, state) => const LoginScreen(),
  );
}
