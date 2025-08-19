import 'package:bloc/bloc.dart';
import 'package:demo_ecommerce/core/models/products/categorie_model.dart';
import 'package:demo_ecommerce/core/models/products/product.dart';
import 'package:demo_ecommerce/core/services/products_api.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._productsApi) : super(HomeLoaded());

  final ProductsApi _productsApi;

  // Initialize data loading
  void initializeHome() {
    loadCategories();
    loadProducts();
  }

  // get all Categories
  void loadCategories() async {
    if (isClosed) return;

    // Set categories loading state
    if (state is HomeLoaded) {
      emit(
        (state as HomeLoaded).copyWith(
          categoriesLoading: true,
          categoriesError: null,
        ),
      );
    } else {
      emit(HomeLoaded(categoriesLoading: true));
    }

    try {
      final categories = await _productsApi.getAllCategories();
      if (isClosed) return;

      if (state is HomeLoaded) {
        emit(
          (state as HomeLoaded).copyWith(
            categories: categories,
            categoriesLoading: false,
          ),
        );
      } else {
        emit(HomeLoaded(categories: categories));
      }
    } catch (e) {
      if (isClosed) return;

      if (state is HomeLoaded) {
        emit(
          (state as HomeLoaded).copyWith(
            categoriesLoading: false,
            categoriesError: 'Failed to load categories: $e',
          ),
        );
      } else {
        emit(HomeError('Failed to load categories'));
      }
    }
  }

  // get all Shuffled Products
  void loadProducts() async {
    if (isClosed) return;

    // Set products loading state
    if (state is HomeLoaded) {
      emit(
        (state as HomeLoaded).copyWith(
          productsLoading: true,
          productsError: null,
        ),
      );
    } else {
      emit(HomeLoaded(productsLoading: true));
    }

    try {
      final products = await _productsApi.getShuffledProducts();
      if (isClosed) return;

      if (state is HomeLoaded) {
        emit(
          (state as HomeLoaded).copyWith(
            products: products,
            productsLoading: false,
          ),
        );
      } else {
        emit(HomeLoaded(products: products));
      }
    } catch (e) {
      if (isClosed) return;

      if (state is HomeLoaded) {
        emit(
          (state as HomeLoaded).copyWith(
            productsLoading: false,
            productsError: 'Failed to load products: $e',
          ),
        );
      } else {
        emit(HomeError('Failed to load products'));
      }
    }
  }

  // get all Featured Products
  void loadFeaturedProducts(int categoryId) async {
    if (isClosed) return;

    if (state is HomeLoaded) {
      emit(
        (state as HomeLoaded).copyWith(
          productsLoading: true,
          productsError: null,
        ),
      );
    } else {
      emit(HomeLoaded(productsLoading: true));
    }

    try {
      final products = await _productsApi.getProductsByCategory(categoryId);
      if (isClosed) return;

      if (state is HomeLoaded) {
        emit(
          (state as HomeLoaded).copyWith(
            products: products,
            productsLoading: false,
          ),
        );
      } else {
        emit(HomeLoaded(products: products));
      }
    } catch (e) {
      if (isClosed) return;

      if (state is HomeLoaded) {
        emit(
          (state as HomeLoaded).copyWith(
            productsLoading: false,
            productsError: 'Failed to load featured products: $e',
          ),
        );
      } else {
        emit(HomeError('Failed to load featured products'));
      }
    }
  }
}
