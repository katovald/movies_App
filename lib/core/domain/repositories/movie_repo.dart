import '../../models/movie.dart';

abstract class MovieRepo {
  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> getNowPlayingMovies();
  Future<List<Movie>> getPagedMovies(int page);
  Future<List<Genre>> getGenres();
  Future<void> addRemoveFav(Movie movie);
}