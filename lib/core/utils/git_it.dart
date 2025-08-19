
import 'package:demo_ecommerce/core/services/auth_service.dart';
import 'package:demo_ecommerce/core/services/products_api.dart';
import 'package:demo_ecommerce/features/auth/controller/cubit/auth_cubit.dart';
import 'package:demo_ecommerce/features/home/controller/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerFactory(() => AuthCubit(getIt<AuthService>()));
  // product and home cubits

  getIt.registerLazySingleton<ProductsApi>(() => ProductsApi());


}
