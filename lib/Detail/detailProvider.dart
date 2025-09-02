import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_api/Detail/movieDetailModel.dart';
import 'package:http/http.dart' as http;

class DetailProvider with ChangeNotifier {
  MovieDetailModel? _movieDetail;
  bool _isLoading = false;
  String _errorMessage = '';

  MovieDetailModel? get movieDetail => _movieDetail;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  DetailProvider() {
    _movieDetail = null;
  }

  Future<void> fetchMovieDetail(int movieId) async {
    if (_isLoading) return; // Prevent multiple calls
    
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId?api_key=b65184d1ea7d849396c5ce79ba26bf3b',
        ),
      );

      if (response.statusCode == 200) {
        _movieDetail = MovieDetailModel.fromJson(json.decode(response.body));
      } else {
        _errorMessage = 'Failed to load movie detail';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

}