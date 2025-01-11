import 'package:blinkit_admin/core/app_secrets.dart';
import 'package:blinkit_admin/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blinkit_admin/features/auth/data/respository_impl/auth_repository_impl.dart';
import 'package:blinkit_admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:blinkit_admin/features/auth/domain/usecases/user_login.dart';
import 'package:blinkit_admin/features/auth/presentation/all_blocs/bloc/auth_bloc.dart';
import 'package:blinkit_admin/features/auth/presentation/all_blocs/cubit/spinner_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

void dependencies() {
  serviceLocator.registerSingleton<http.Client>(http.Client());
  authDependencies();
}

void authDependencies() {
  
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      baseUrl: AppSecrets.baseUrl,
      client: serviceLocator<http.Client>(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: serviceLocator<AuthRemoteDataSource>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLogin(
      authRepository: serviceLocator<AuthRepository>(),
    ),
  );
  serviceLocator.registerLazySingleton(()=> AuthBloc(userLogin: serviceLocator<UserLogin>()));
  serviceLocator.registerLazySingleton(()=> SpinnerCubit());
}
