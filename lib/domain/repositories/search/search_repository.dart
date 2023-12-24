import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  /// Return a list of apod date on right side of either case is a success, otherwise
  /// Return a failure on a Left side of either
  Future<Either<Failure, List<Apod>>> fetchApodByDateRange(
      String startDate, String endDate);

  /// Return a String List on a right side of either case is a success, otherwise
  /// Return a Failure on a left side of either
  Future<Either<Failure, List<String>>> updateSearchHistory(
      List<String> historyList);

  /// Return a String List on Right side of Either case is a success, otherwise]
  /// Return a Failure on Left side of Either
  Future<Either<Failure, List<String>>> fetchSearchHistory();
}
