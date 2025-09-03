import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../network/api_client.dart';
import '../../features/movies/data/datasources/movie_remote_data_source.dart';
import '../../features/movies/data/repositories/movie_repository_impl.dart';
import '../../features/movies/domain/repositories/movie_repository.dart';
import '../../features/movies/domain/usecases/get_popular_movies.dart';
import '../../features/movies/domain/usecases/get_upcoming_movies.dart';
import '../../features/movies/domain/usecases/get_top_rated_movies.dart';
import '../../features/movies/domain/usecases/get_now_playing_movies.dart';
import '../../features/movies/domain/usecases/search_movies.dart';
import '../../features/movies/domain/usecases/get_movies_by_genre.dart';
import '../../features/movies/domain/usecases/get_movie_detail.dart';
import '../../presentation/providers/home_provider.dart';
import '../../presentation/providers/search_provider.dart';
import '../../presentation/providers/genre_provider.dart';
import '../../presentation/providers/detail_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Providers
  sl.registerFactory(() => HomeProvider(
        getPopularMovies: sl(),
        getUpcomingMovies: sl(),
        getTopRatedMovies: sl(),
        getNowPlayingMovies: sl(),
      ));
  
  sl.registerFactory(() => SearchProvider(searchMovies: sl()));
  sl.registerFactory(() => GenreProvider(getMoviesByGenre: sl()));
  sl.registerFactory(() => DetailProvider(getMovieDetail: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetPopularMovies(sl()));
  sl.registerLazySingleton(() => GetUpcomingMovies(sl()));
  sl.registerLazySingleton(() => GetTopRatedMovies(sl()));
  sl.registerLazySingleton(() => GetNowPlayingMovies(sl()));
  sl.registerLazySingleton(() => SearchMovies(sl()));
  sl.registerLazySingleton(() => GetMoviesByGenre(sl()));
  sl.registerLazySingleton(() => GetMovieDetail(sl()));

  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(apiClient: sl()),
  );

  // Core
  sl.registerLazySingleton(() => ApiClient(client: sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
}
