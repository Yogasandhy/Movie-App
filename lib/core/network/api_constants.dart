class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'b65184d1ea7d849396c5ce79ba26bf3b';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  
  // Endpoints
  static const String popularMovies = '/movie/popular';
  static const String upcomingMovies = '/movie/upcoming';
  static const String topRatedMovies = '/movie/top_rated';
  static const String nowPlayingMovies = '/movie/now_playing';
  static const String searchMovies = '/search/movie';
  static const String discoverMovies = '/discover/movie';
  static String movieDetails(int movieId) => '/movie/$movieId';
}
