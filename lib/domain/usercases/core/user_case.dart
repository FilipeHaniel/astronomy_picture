import 'package:astronomy_picture/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UserCase<R, P> {
  /// Default UserCase
  /// R is the return of function call
  /// P is tthe paramerer of function call

  Future<Either<Failure, R>> call(P parameter);
}

class NoParameter {}
