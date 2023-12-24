import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositories/search/search_repository.dart';
import 'package:astronomy_picture/domain/usercases/core/user_case.dart';
import 'package:dartz/dartz.dart';

class FetchApodByDataRange extends UserCase<List<Apod>, String> {
  final SearchRepository _repository;

  FetchApodByDataRange({required SearchRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<Apod>>> call(String parameter) async {
    final query = toStandardQuery(parameter).fold(
      (l) => l,
      (r) => r,
    );

    if (query is Map) {
      return await _repository.fetchApodByDateRange(
          query['start'], query['end']);
    } else {
      return Left(query as Failure);
    }
  }

  // 2023-08-13/2023-08-15
  Either<Failure, Map<String, dynamic>> toStandardQuery(String query) {
    if (query.length == 21) {
      final list = query.split('/');

      if (list.length == 2) {
        try {
          DateTime.tryParse(list[0]);
          DateTime.tryParse(list[1]);

          return Right({
            'start': list[0],
            'end': list[1],
          });
        } catch (e) {
          return Left(ConvertFailure());
        }
      }
    }
    if (query.length == 10) {
      try {
        DateTime.tryParse(query);

        return Right({
          'start': query,
          'end': query,
        });
      } catch (e) {
        return Left(ConvertFailure());
      }
    } else {
      return left(ConvertFailure());
    }
  }
}
