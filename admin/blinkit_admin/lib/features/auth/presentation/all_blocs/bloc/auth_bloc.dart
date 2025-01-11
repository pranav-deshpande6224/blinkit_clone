import 'package:blinkit_admin/core/common/entities/profile_user.dart';
import 'package:blinkit_admin/features/auth/domain/usecases/user_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin userLogin;
  AuthBloc({
    required this.userLogin,
  }) : super(AuthInitial()) {
    on<AuthLoginEvent>(_authLogin);
  }

  void _authLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await userLogin.call(
      UserLoginParams(email: event.email, password: event.password),
    );
    res.fold(
      (l) {
        print(l);
        emit(AuthFailure(message: l.message));
      },
      (r) => emit(AuthSuccess(user: r)),
    );
  }
}
