import 'package:bloc/bloc.dart';
import 'package:demo_ecommerce/core/models/app_user.dart';
import 'package:demo_ecommerce/core/services/auth_service.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authService) : super(AuthInitial());

  final AuthService _authService ;

  void signIn(String email, String password) async {
    emit(AuthLoading());
    final result = await _authService.signIn(email, password);
    if (result.isSuccess) {
      emit(Authenticated(result.data!));
    } else {
      emit(AuthError(result.error!));
    }
  }

  void signOut() async {
    emit(AuthLoading());
    final result = await _authService.signOut();
    if (result.isSuccess) {
      emit(AuthInitial());
    } else {
      emit(AuthError(result.error!));
    }
  }

  void register(String email, String password, {String? displayName}) async {
    emit(AuthLoading());
    final result = await _authService.register(email, password, displayName: displayName);
    if (result.isSuccess) {
      emit(Authenticated(result.data!));
    } else {
      emit(AuthError(result.error!));
    }
  }

}
