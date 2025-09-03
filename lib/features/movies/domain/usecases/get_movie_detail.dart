import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetail implements UseCase<MovieDetail, int> {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  @override
  Future<Either<Failure, MovieDetail>> call(int movieId) async {
    return await repository.getMovieDetail(movieId);
  }
}
