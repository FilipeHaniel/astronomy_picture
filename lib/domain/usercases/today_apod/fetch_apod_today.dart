import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:astronomy_picture/domain/usercases/core/user_case.dart';
import 'package:dartz/dartz.dart';

class FetchApodToday extends UserCase<Apod, NoParameter> {
  final TodayApodRepository _repository;

  FetchApodToday({required TodayApodRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, Apod>> call(NoParameter paramerer) async {
    return await _repository.fetchApodToday();
  }
}
