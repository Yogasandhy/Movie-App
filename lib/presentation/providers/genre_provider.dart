import 'package:flutter/foundation.dart';
import '../../features/movies/domain/entities/movie.dart';
import '../../features/movies/domain/usecases/get_movies_by_genre.dart';

class GenreProvider with ChangeNotifier {
  final GetMoviesByGenre getMoviesByGenre;

  GenreProvider({required this.getMoviesByGenre});

  List<Movie> _moviesByGenre = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Movie> get moviesByGenre => _moviesByGenre;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchMoviesByGenre(int genreId) async {
    _setLoading(true);
    final result = await getMoviesByGenre(genreId);
    result.fold(
      (failure) => _setError(failure.message),
      (movies) {
        _moviesByGenre = movies;
        _clearError();
      },
    );
    _setLoading(false);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = '';
    notifyListeners();
  }
}
