import 'package:flutter/foundation.dart';
import '../../features/movies/domain/entities/movie_detail.dart';
import '../../features/movies/domain/usecases/get_movie_detail.dart';

class DetailProvider with ChangeNotifier {
  final GetMovieDetail getMovieDetail;

  DetailProvider({required this.getMovieDetail});

  MovieDetail? _movieDetail;
  bool _isLoading = false;
  String _errorMessage = '';

  MovieDetail? get movieDetail => _movieDetail;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchMovieDetail(int movieId) async {
    if (_isLoading) return; // Prevent multiple calls
    
    _setLoading(true);
    final result = await getMovieDetail(movieId);
    result.fold(
      (failure) => _setError(failure.message),
      (movieDetail) {
        _movieDetail = movieDetail;
        _clearError();
      },
    );
    _setLoading(false);
  }

  void clearMovieDetail() {
    _movieDetail = null;
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
