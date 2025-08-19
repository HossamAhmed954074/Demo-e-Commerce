import 'package:demo_ecommerce/core/services/products_api.dart';
import 'package:demo_ecommerce/core/utils/git_it.dart';
import 'package:demo_ecommerce/features/cart/view/screens/cart_screen.dart';
import 'package:demo_ecommerce/features/home/controller/cubit/home_cubit.dart';
import 'package:demo_ecommerce/features/home/view/screens/home_screen.dart';
import 'package:demo_ecommerce/features/profile/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      BlocProvider(
        create: (context) => HomeCubit(getIt<ProductsApi>())..initializeHome(),
        child: HomeScreen(),
      ),
      CartScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      // controller: PersistentTabController(),
      screens: _screens,
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: const Color(0xFF7B61FF).withValues(alpha: 0.2),
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          // Screen transition animation on change of selected tab.
          animateTabTransition: false,
          duration: Duration(milliseconds: 50),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: "Home",
        activeColorPrimary: const Color(0xFFFF6B6B),
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: const Color(0xFF00C2A8).withValues(alpha: 0.4),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart),
        title: "Cart",
        activeColorPrimary: const Color(0xFFFF6B6B),
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: const Color(0xFF00C2A8).withValues(alpha: 0.4),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.profile_circled),
        title: "Profile",
        activeColorPrimary: const Color(0xFFFF6B6B),
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: const Color(0xFF00C2A8).withValues(alpha: 0.4),
      ),
    ];
  }
}
