
import 'package:blinkit_admin/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

// success is nothing but we are returning a type of SuccessType
// params that we pass
abstract interface class Usecase<SuccessType, Params >{
  Future<Either<Failure,SuccessType>> call(Params params);
}
class NoParams {}
