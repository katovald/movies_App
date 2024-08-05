import 'package:movie_app/core/models/api_response.dart';

import '../../models/movie.dart';

abstract class MovieRepo {
  Future<ApiResponse> getPopularMovies();
  Future<ApiResponse> getNowPlayingMovies();
  Future<ApiResponse> getPagedMovies(int page);
  Future<Genre> getGenres();
  Future<void> addRemoveFav(Movie movie);
}