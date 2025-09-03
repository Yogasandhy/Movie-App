import 'package:flutter/foundation.dart';
import '../../core/usecases/usecase.dart';
import '../../features/movies/domain/entities/movie.dart';
import '../../features/movies/domain/usecases/get_popular_movies.dart';
import '../../features/movies/domain/usecases/get_upcoming_movies.dart';
import '../../features/movies/domain/usecases/get_top_rated_movies.dart';
import '../../features/movies/domain/usecases/get_now_playing_movies.dart';

class HomeProvider with ChangeNotifier {
  final GetPopularMovies getPopularMovies;
  final GetUpcomingMovies getUpcomingMovies;
  final GetTopRatedMovies getTopRatedMovies;
  final GetNowPlayingMovies getNowPlayingMovies;

  HomeProvider({
    required this.getPopularMovies,
    required this.getUpcomingMovies,
    required this.getTopRatedMovies,
    required this.getNowPlayingMovies,
  });

  List<Movie> _popularMovies = [];
  List<Movie> _upcomingMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Movie> _nowPlayingMovies = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get upcomingMovies => _upcomingMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchPopularMovies() async {
    _setLoading(true);
    final result = await getPopularMovies(const NoParams());
    result.fold(
      (failure) => _setError(failure.message),
      (movies) {
        _popularMovies = movies;
        _clearError();
      },
    );
    _setLoading(false);
  }

  Future<void> fetchUpcomingMovies() async {
    _setLoading(true);
    final result = await getUpcomingMovies(const NoParams());
    result.fold(
      (failure) => _setError(failure.message),
      (movies) {
        _upcomingMovies = movies;
        _clearError();
      },
    );
    _setLoading(false);
  }

  Future<void> fetchTopRatedMovies() async {
    _setLoading(true);
    final result = await getTopRatedMovies(const NoParams());
    result.fold(
      (failure) => _setError(failure.message),
      (movies) {
        _topRatedMovies = movies;
        _clearError();
      },
    );
    _setLoading(false);
  }

  Future<void> fetchNowPlayingMovies() async {
    _setLoading(true);
    final result = await getNowPlayingMovies(const NoParams());
    result.fold(
      (failure) => _setError(failure.message),
      (movies) {
        _nowPlayingMovies = movies;
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
