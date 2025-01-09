import 'package:blinkit_admin/features/auth/presentation/cubit/password_cubit.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void initDependencies() {
  serviceLocator.registerLazySingleton(() => PasswordCubit());
}
