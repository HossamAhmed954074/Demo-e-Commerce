
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_ecommerce/features/home/controller/cubit/home_cubit.dart';
import 'package:demo_ecommerce/features/home/view/widgets/category_section.dart';
import 'package:demo_ecommerce/features/home/view/widgets/home_header_section.dart';
import 'package:demo_ecommerce/features/home/view/widgets/product_section.dart';
import 'package:demo_ecommerce/features/home/view/widgets/search_section.dart';

// Constants 
class HomeConstants {
  static const double gridAspectRatio = 0.75;
  static const double categoryHeight = 80.0;
  static const double productImageHeight = 140.0;
  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsets gridPadding = EdgeInsets.symmetric(horizontal: 12.0);
  static const BorderRadius defaultBorderRadius = BorderRadius.all(
    Radius.circular(12.0),
  );
  static const Duration animationDuration = Duration(milliseconds: 200);
}

// Theme extensions for consistent styling
extension HomeTheme on BuildContext {
  Color get cardColor => Theme.of(this).cardColor;
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get surfaceColor => Theme.of(this).colorScheme.surface;
  TextStyle get titleStyle => Theme.of(
    this,
  ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600);
  TextStyle get priceStyle => Theme.of(this).textTheme.bodyLarge!.copyWith(
    color: Colors.green.shade700,
    fontWeight: FontWeight.w600,
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: _handleStateChanges,
          builder: (context, state) => _buildBody(context, state),
        ),
      ),
    );
  }

  void _handleStateChanges(BuildContext context, HomeState state) {
    if (state is HomeError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
            margin: HomeConstants.defaultPadding,
          ),
        );
      });
    }
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: HomeHeaderSection()),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: SearchSection(onClear: () {}),
          ),
        ),
        SliverToBoxAdapter(
          child: CategorySection(
            categories: state is HomeLoaded ? state.categories : [],
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        ProductsSection(products: state is HomeLoaded ? state.products : []),
      ],
    );
  }
}

