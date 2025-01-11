
//class UserLogin implements Usecase

import 'package:blinkit_admin/core/common/entities/profile_user.dart';
import 'package:blinkit_admin/core/error/failure.dart';
import 'package:blinkit_admin/core/usecase/usecase.dart';
import 'package:blinkit_admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements Usecase<ProfileUser, UserLoginParams> {
  final AuthRepository authRepository;
  UserLogin({required this.authRepository});
  @override
  Future<Either<Failure, ProfileUser>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;
  UserLoginParams({required this.email, required this.password});
}