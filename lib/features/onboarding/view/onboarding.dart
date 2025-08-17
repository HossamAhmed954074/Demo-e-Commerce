import 'package:demo_ecommerce/core/utils/assets.dart';
import 'package:demo_ecommerce/features/onboarding/model/onboarding.dart';
import 'package:demo_ecommerce/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _index = 0;

  final List<Onboarding> onboardingItems = [
    Onboarding(
      title: 'Welcome',
      description: 'Welcome to our app — fast, simple and beautiful.',
      image: Assets.onBoarding1,
      color: const Color(0xFF7B61FF),
    ),
    Onboarding(
      title: 'Discover',
      description: 'Discover curated products and deals just for you.',
      image: Assets.onBoarding2,
      color: const Color(0xFF00C2A8),
    ),
    Onboarding(
      title: 'Get Started',
      description: 'Sign up and start shopping in seconds.',
      image: Assets.onBoarding3,
      color: const Color(0xFFFF6B6B),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNext() {
    if (_index < onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _skip() {
    _pageController.jumpToPage(onboardingItems.length - 1);
  }

  void _finishOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    if (mounted) {
      context.goNamed(AppRouter.bottomNavName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = onboardingItems[_index];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      color: current.color.withOpacity(0.08),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              // Top bar: Skip
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _skip,
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              // Page view
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingItems.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) {
                    final item = onboardingItems[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image with subtle animation
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: Image.asset(
                              item.image,
                              key: ValueKey(item.image),
                              height: 260,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 28),
                          // Title
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 400),
                            opacity: _index == i ? 1 : 0.6,
                            child: Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Description
                          Text(
                            item.description,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.white, height: 1.4),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Indicators + Next/get started
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20,
                ),
                child: Row(
                  children: [
                    // Dots
                    Row(
                      children: List.generate(onboardingItems.length, (i) {
                        final active = i == _index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width: active ? 20 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: active
                                ? onboardingItems[_index].color
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        );
                      }),
                    ),

                    const Spacer(),

                    // Next or Get Started
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: onboardingItems[_index].color,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _goToNext,
                      child: Text(
                        _index == onboardingItems.length - 1
                            ? 'Get Started'
                            : 'Next',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
