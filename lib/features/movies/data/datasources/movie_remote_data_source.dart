import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_constants.dart';
import '../models/movie_model.dart';
import '../models/movie_detail_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getUpcomingMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> searchMovies(String query);
  Future<List<MovieModel>> getMoviesByGenre(int genreId);
  Future<MovieDetailModel> getMovieDetail(int movieId);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClient apiClient;

  MovieRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await apiClient.get(
        '${ApiConstants.baseUrl}${ApiConstants.popularMovies}?api_key=${ApiConstants.apiKey}',
      );
      final movieList = MovieListModel.fromJson(response);
      return movieList.results;
    } catch (e) {
      throw ServerException('Failed to fetch popular movies: $e');
    }
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies() async {
    try {
      final response = await apiClient.get(
        '${ApiConstants.baseUrl}${ApiConstants.upcomingMovies}?api_key=${ApiConstants.apiKey}',
      );
      final movieList = MovieListModel.fromJson(response);
      return movieList.results;
    } catch (e) {
      throw ServerException('Failed to fetch upcoming movies: $e');
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      final response = await apiClient.get(
        '${ApiConstants.baseUrl}${ApiConstants.topRatedMovies}?api_key=${ApiConstants.apiKey}',
      );
      final movieList = MovieListModel.fromJson(response);
      return movieList.results;
    } catch (e) {
      throw ServerException('Failed to fetch top rated movies: $e');
    }
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      final response = await apiClient.get(
        '${ApiConstants.baseUrl}${ApiConstants.nowPlayingMovies}?api_key=${ApiConstants.apiKey}',
      );
      final movieList = MovieListModel.fromJson(response);
      return movieList.results;
    } catch (e) {
      throw ServerException('Failed to fetch now playing movies: $e');
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await apiClient.get(
        '${ApiConstants.baseUrl}${ApiConstants.searchMovies}?api_key=${ApiConstants.apiKey}&query=$query',
      );
      final movieList = MovieListModel.fromJson(response);
      return movieList.results;
    } catch (e) {
      throw ServerException('Failed to search movies: $e');
    }
  }

  @override
  Future<List<MovieModel>> getMoviesByGenre(int genreId) async {
    try {
      final response = await apiClient.get(
        '${ApiConstants.baseUrl}${ApiConstants.discoverMovies}?api_key=${ApiConstants.apiKey}&with_genres=$genreId',
      );
      final movieList = MovieListModel.fromJson(response);
      return movieList.results;
    } catch (e) {
      throw ServerException('Failed to fetch movies by genre: $e');
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    try {
      final response = await apiClient.get(
        '${ApiConstants.baseUrl}${ApiConstants.movieDetails(movieId)}?api_key=${ApiConstants.apiKey}',
      );
      return MovieDetailModel.fromJson(response);
    } catch (e) {
      throw ServerException('Failed to fetch movie detail: $e');
    }
  }
}
