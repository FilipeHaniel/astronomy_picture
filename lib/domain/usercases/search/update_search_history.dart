import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositories/search/search_repository.dart';
import 'package:astronomy_picture/domain/usercases/core/user_case.dart';
import 'package:dartz/dartz.dart';

class UpdateSearchHistory extends UserCase<List<String>, List<String>> {
  final SearchRepository _repository;

  UpdateSearchHistory({required SearchRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<String>>> call(List<String> parameter) async {
    return await _repository.updateSearchHistory(parameter);
  }
}
