part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<Category> categories;
  final List<Product> products;
  final bool categoriesLoading;
  final bool productsLoading;
  final String? categoriesError;
  final String? productsError;

  HomeLoaded({
    this.categories = const [],
    this.products = const [],
    this.categoriesLoading = false,
    this.productsLoading = false,
    this.categoriesError,
    this.productsError,
  });

  HomeLoaded copyWith({
    List<Category>? categories,
    List<Product>? products,
    bool? categoriesLoading,
    bool? productsLoading,
    String? categoriesError,
    String? productsError,
  }) {
    return HomeLoaded(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      categoriesLoading: categoriesLoading ?? this.categoriesLoading,
      productsLoading: productsLoading ?? this.productsLoading,
      categoriesError: categoriesError ?? this.categoriesError,
      productsError: productsError ?? this.productsError,
    );
  }
}

// Keep these for backward compatibility if needed
final class HomeLoadedProducts extends HomeState {
  final List<Product> products;
  HomeLoadedProducts(this.products);
}

final class HomeLoadedCategories extends HomeState {
  final List<Category> categories;
  HomeLoadedCategories(this.categories);
}

final class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
