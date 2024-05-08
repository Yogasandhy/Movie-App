import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_api/movie_model.dart';

class HomeProvider with ChangeNotifier {
  List<Result> _popularMovies = [];
  List<Result> _upcomingMovies = [];
  List<Result> _topratedmovies = [];
  List<Result> _nowplayingmovies = [];

  List<Result> get popularMovies => _popularMovies;
  List<Result> get upcomingMovies => _upcomingMovies;
  List<Result> get topratedmovies => _topratedmovies;
  List<Result> get nowplayingmovies => _nowplayingmovies;

  Future<void> fetchPopularMovies() async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=b65184d1ea7d849396c5ce79ba26bf3b',
      ),
    );
    if (response.statusCode == 200) {
      Moviemodel movieModel = Moviemodel.fromJson(json.decode(response.body));
      _popularMovies = movieModel.results;
      notifyListeners();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

   
  Future<void> fetchNowPlayingMovies() async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=b65184d1ea7d849396c5ce79ba26bf3b'),
    );
    if (response.statusCode == 200) {
      Moviemodel movieModel = Moviemodel.fromJson(json.decode(response.body));
      _nowplayingmovies = movieModel.results;
      notifyListeners();
    } else {
      throw Exception('Failed to load now playing movies');
    }
  }

  Future<void> fetchTopRatedMovies() async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=b65184d1ea7d849396c5ce79ba26bf3b',
      ),
    );
    if (response.statusCode == 200) {
      Moviemodel movieModel = Moviemodel.fromJson(json.decode(response.body));
      _topratedmovies = movieModel.results;
      notifyListeners();
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  Future<void> fetchUpcomingMovies() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.themoviedb.org/3/movie/upcoming?api_key=b65184d1ea7d849396c5ce79ba26bf3b',
        ),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Data received: $data');
        if (data != null) {
          Moviemodel movieModel = Moviemodel.fromJson(data);
          _upcomingMovies = movieModel.results;
          notifyListeners();
        } else {
          throw Exception('No data received');
        }
      } else {
        throw Exception('Failed to load upcoming movies');
      }
    } catch (error) {
      print('Error fetching upcoming movies: $error');
    }
  }
}
