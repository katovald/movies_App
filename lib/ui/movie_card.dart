import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../core/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final isFavorite = moviesProvider.isFavorite(movie);

    return Card(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                movie.posterPath.isNotEmpty
                  ? Image.network(
                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                fit: BoxFit.contain,
                width: double.infinity,
              )
                  : Container(
                color: Colors.grey,
                child: const Center(child: Text('No Image')),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    if (isFavorite) {
                      moviesProvider.addRemoveFav(movie);
                    } else {
                      moviesProvider.addRemoveFav(movie);
                    }
                  },
                ),
              ),],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  movie.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  'Genres: ${movie.genres.map((e) => e).join(', ')}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Overview: ${movie.overview}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Popularity: ${movie.popularity}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Release Date: ${movie.releaseDate}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Language: ${movie.languages}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Vote Average: ${movie.voteAvg}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}