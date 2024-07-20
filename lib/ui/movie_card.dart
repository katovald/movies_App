import 'package:flutter/material.dart';

import '../core/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            fit: BoxFit.cover,
          ),
          Text(movie.title),
          Text('Genres: ${movie.genres.map((e) => e).join(', ')}'),
          Text('Overview: ${movie.overview}'),
          Text('Popularity: ${movie.popularity}'),
          Text('Release Date: ${movie.releaseDate}'),
          Text('Language: ${movie.languages.map((e) => e.name).join(', ')}'),
          Text('Vote Average: ${movie.voteAvg}'),
          //Text('Status: ${movie.status}'),
        ],
      ),
    );
  }
}