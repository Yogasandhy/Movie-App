import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_api/movie_model.dart';

class SearchProvider with ChangeNotifier {
  List<Result> _searchResults = [];

  List<Result> get searchResults => _searchResults;

  Future<void> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=b65184d1ea7d849396c5ce79ba26bf3b&query=$query',
      ),
    );
    if (response.statusCode == 200) {
      Moviemodel movieModel = Moviemodel.fromJson(json.decode(response.body));
      _searchResults = movieModel.results;
      notifyListeners();
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
