import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/core/models/movie.dart';
import 'package:movie_app/core/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoviesProvider extends ChangeNotifier {
  List<Movie> _movies = [];
  List<Movie> get popular => _movies;

  List<String> _favorites = [];
  List<String> get favorites => _favorites;

  bool _gridview = false;
  bool get gridview => _gridview;

  bool _loading = true;
  bool get loading => _loading;

  bool _isPopular = false;
  bool get isPopular => _isPopular;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final ApiService api;
  final String _apiKey = dotenv.env['API_KEY']!;

  MoviesProvider({required this.api}) {
    loadFavorites();
  }

  void changeView() {
    _gridview = !_gridview;
    notifyListeners();
  }

  void changeData() {
    _isPopular = !_isPopular;
    _loading = true;
    notifyListeners();
    fetchData();
  }

  Future<void> fetchData() async {
    if (_isPopular) {
      await fetchPopular();
    } else {
      await fetchNowPlaying();
    }
  }

  Future<void> fetchPopular() async {
    try {
      final response = await api.getPopularMovies(_apiKey);
      _movies = response.movies;
      _loading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchNowPlaying() async {
    try {
      final response = await api.getNowPlayingMovies(_apiKey);
      _movies = response.movies;
      _loading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPage(int page) async {
    try {
      final response = await api.getPagedMovies(_apiKey, page);
      _movies = response.movies;
      _loading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchGenres() async {
    try {
      final response = await api.getGenres(_apiKey);
      _loading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _loading = false;
      notifyListeners();
    }
  }

  void addRemoveFav(Movie movie) {
    if(_favorites.contains(movie.title)) {
      _favorites.remove(movie.title);
    } else {
      _favorites.add(movie.title);
    }
    saveFavorites();
    notifyListeners();
  }

  bool isFavorite(Movie movie) {
    return _favorites.contains(movie.title);
  }

  Future<void> saveFavorites() async {
    // save favorites to local storage
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', _favorites);
  }

  Future<void> loadFavorites() async {
    // load favorites from local storage
    final prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList('favorites') ?? [];
    notifyListeners();
  }
}