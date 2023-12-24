import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositories/search/search_repository.dart';
import 'package:astronomy_picture/domain/usercases/core/user_case.dart';
import 'package:dartz/dartz.dart';

class FetchSearchHistory extends UserCase<List<String>, NoParameter> {
  final SearchRepository _repository;

  FetchSearchHistory({required SearchRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<String>>> call(NoParameter parameter) async {
    return await _repository.fetchSearchHistory();
  }
}
