import 'package:movie_app/core/models/api_response.dart';
import 'package:movie_app/core/models/movie.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://api.themoviedb.org/3')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('movie/popular')
  Future<ApiResponse> getPopularMovies(@Query('api_key') String apiKey);

  //date must have YYYY-MM-DD format
  @GET('movie/now_playing')
  Future<ApiResponse> getNowPlayingMovies(@Query('api_key') String apiKey);

  @GET('discover/movie')
  Future<ApiResponse> getPagedMovies(@Query('api_key') String apiKey, @Query('page') int page);

  @GET('genre/movie/list')
  Future<Genre> getGenres(@Query('api_key') String apiKey);
}