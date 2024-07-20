import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/core/models/movie.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  @JsonKey(name: 'results')
  List<Movie> movies;

  ApiResponse({
    required this.movies,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}