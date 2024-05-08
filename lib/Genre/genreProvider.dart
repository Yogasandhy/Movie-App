import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_api/movie_model.dart';
import 'package:http/http.dart' as http;

class GenreProvider with ChangeNotifier{
  List<Result> _moviesByGenre = [];

  List<Result> get moviesByGenre => _moviesByGenre;

  Future<void> fetchMoviesByGenre(int genreId) async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=b65184d1ea7d849396c5ce79ba26bf3b&with_genres=$genreId',
      ),
    );
    if (response.statusCode == 200) {
      Moviemodel movieModel = Moviemodel.fromJson(json.decode(response.body));
      _moviesByGenre = movieModel.results;
      notifyListeners();
    } else {
      throw Exception('Failed to load movies by genre');
    }
  }

}