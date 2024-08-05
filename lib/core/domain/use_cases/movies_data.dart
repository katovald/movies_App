import 'package:movie_app/core/domain/repositories/movie_repo.dart';
import 'package:movie_app/core/models/api_response.dart';
import 'package:movie_app/core/models/movie.dart';

class MoviesData implements MovieRepo{
  final MovieRepo repository;

  MoviesData(this.repository);

  Future<ApiResponse> execute() async {
    return await repository.getNowPlayingMovies();
  }

  @override
  Future<void> addRemoveFav(Movie movie) async {
    repository.addRemoveFav(movie);
  }

  @override
  Future<Genre> getGenres() {
    // TODO: implement getGenres
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> getNowPlayingMovies() async {
    return await repository.getNowPlayingMovies();
  }

  @override
  Future<ApiResponse> getPagedMovies(int page) {
    // TODO: implement getPagedMovies
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> getPopularMovies() {
    // TODO: implement getPopularMovies
    throw UnimplementedError();
  }
}