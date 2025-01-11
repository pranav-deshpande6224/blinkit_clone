import 'package:blinkit_admin/core/common/entities/profile_user.dart';
import 'package:blinkit_admin/core/error/exception.dart';
import 'package:blinkit_admin/core/error/failure.dart';
import 'package:blinkit_admin/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blinkit_admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({
    required this.authRemoteDataSource,
  });
  @override
  Future<Either<Failure, ProfileUser>> currentUser() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProfileUser>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await authRemoteDataSource.loginWithEmailAndPassword(
          email: email, password: password);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: 'Unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, ProfileUser>> signUpWithEmailAndPassword(
      {required String email, required String password, required String name}) {
    // TODO: implement signUpWithEmailAndPassword
    throw UnimplementedError();
  }
}
