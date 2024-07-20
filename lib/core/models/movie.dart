import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'poster_path')
  final String posterPath;

  @JsonKey(name: 'genre_ids')
  final List<int> genres;

  @JsonKey(name: 'release_date')
  final String releaseDate;

  @JsonKey(name: 'overview')
  final String overview;

  @JsonKey(name: 'popularity')
  final double popularity;

  @JsonKey(name: 'original_language')
  final String languages;

  @JsonKey(name: 'vote_average')
  final int voteAvg;

  //@JsonKey(name: 'status')
  //final String status;

  Movie({
    required this.title,
    required this.posterPath,
    required this.genres,
    required this.releaseDate,
    required this.overview,
    required this.popularity,
    required this.languages,
    required this.voteAvg,
    //required this.status,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

@JsonSerializable()
class Language {
  final String name;

  Language({
    required this.name,
  });

  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}

@JsonSerializable()
class Genre {
  @JsonKey(name: 'name')
  final String name;

  Genre({
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}