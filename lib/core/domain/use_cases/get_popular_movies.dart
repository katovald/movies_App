import 'package:movie_app/core/domain/repositories/movie_repo.dart';
import 'package:movie_app/core/models/movie.dart';

class GetPopularMovies {
  final MovieRepo repository;

  GetPopularMovies(this.repository);

  Future<List<Movie>> execute() async {
    return await repository.getPopularMovies();
  }
}