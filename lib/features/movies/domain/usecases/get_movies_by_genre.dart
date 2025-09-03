import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetMoviesByGenre implements UseCase<List<Movie>, int> {
  final MovieRepository repository;

  GetMoviesByGenre(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> call(int genreId) async {
    return await repository.getMoviesByGenre(genreId);
  }
}
