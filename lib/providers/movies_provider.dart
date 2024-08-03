import 'package:flutter/material.dart';
import 'package:movie_app/core/domain/use_cases/get_popular_movies.dart';
import 'package:movie_app/core/models/movie.dart';

class MoviesProvider extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;
  //final GetNowPlayingMovies getNowPlayingMovies;

  //Dependency injection
  MoviesProvider({required this.getPopularMovies});

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  Future<void> fetchPopularMovies() async {
    _movies = await getPopularMovies.execute();
    notifyListeners();
  }
}