import 'package:blinkit_admin/core/common/entities/profile_user.dart';
import 'package:blinkit_admin/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';


abstract interface class AuthRepository {
  Future<Either<Failure, ProfileUser>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });
  Future<Either<Failure, ProfileUser>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, ProfileUser>> currentUser();
}
