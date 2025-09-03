import 'package:flutter/foundation.dart';
import '../../features/movies/domain/entities/movie.dart';
import '../../features/movies/domain/usecases/search_movies.dart';

class SearchProvider with ChangeNotifier {
  final SearchMovies searchMovies;

  SearchProvider({required this.searchMovies});

  List<Movie> _searchResults = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Movie> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> searchMoviesWithQuery(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _setLoading(true);
    final result = await searchMovies(query);
    result.fold(
      (failure) => _setError(failure.message),
      (movies) {
        _searchResults = movies;
        _clearError();
      },
    );
    _setLoading(false);
  }

  void clearSearch() {
    _searchResults = [];
    _clearError();
    notifyListeners();
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
