import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/core/models/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/movie.dart';
import '../../services/api_service.dart';
import '../../services/storage_service.dart';

class MovieRepoCalls {
  final ApiService api;
  final StorageService storageService;

  final String _apiKey = dotenv.env['API_KEY']!;

  MovieRepoCalls({
    required this.api,
    required this.storageService,
  });

  Future<ApiResponse> getPopularMovies() async {
    return await api.getPopularMovies(_apiKey);
  }

  Future<ApiResponse> getNowPlayingMovies() async {
    return await api.getNowPlayingMovies(_apiKey);
  }

  Future<ApiResponse> getPagedMovies(int page) async {
    return await api.getPagedMovies(_apiKey, page);
  }

  Future<Genre> getGenres() async {
    return await api.getGenres(_apiKey);
  }

  Future<void> addRemoveFav(Movie movie) async {
    return await storageService.addRemoveFav(movie);
  }
}