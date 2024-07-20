import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/core/models/movie.dart';
import 'package:movie_app/core/services/api_service.dart';

class MoviesProvider extends ChangeNotifier {
  List<Movie> _popular = [];
  List<Movie> _nowPlaying = [];
  List<Movie> _topRated = [];

  List<Movie> get popular => _popular;
  List<Movie> get nowPlaying => _nowPlaying;
  List<Movie> get topRated => _topRated;

  bool _gridview = false;
  bool get gridview => _gridview;

  bool _loading = true;
  bool get loading => _loading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final ApiService api;
  final String _apiKey = dotenv.env['API_KEY']!;

  MoviesProvider({required this.api});

  void changeView() {
    _gridview = !_gridview;
    notifyListeners();
  }

  Future<void> fetchPopular() async {
    try {
      final response = await api.getPopularMovies(_apiKey);
      _popular = response.movies;
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
      _nowPlaying = response.movies;
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
      _topRated = response.movies;
      _loading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _loading = false;
      notifyListeners();
    }
  }
}