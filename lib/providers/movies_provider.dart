import 'package:flutter/material.dart';
import 'package:movie_app/core/domain/use_cases/movies_data.dart';
import 'package:movie_app/core/models/api_response.dart';
import 'package:movie_app/core/models/movie.dart';

class MoviesProvider extends ChangeNotifier {
  final MoviesData getPopularMovies;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _gridView = true;
  bool get gridView => _gridView;

  //Dependency injection
  MoviesProvider({required this.getPopularMovies});

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  Future<void> fetchPopularMovies() async {
    ApiResponse response = await getPopularMovies.execute();
    _movies = response.movies;
    notifyListeners();
  }

  void toggleView() {
    _gridView = !_gridView;
    notifyListeners();
  }

  void setFav(Movie movie) {
    getPopularMovies.addRemoveFav(movie);
    notifyListeners();
  }
}