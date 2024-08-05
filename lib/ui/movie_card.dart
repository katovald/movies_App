import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../core/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 300,
        child: Column(
          children: [
            Expanded(
              flex: 2,
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
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {
                        Provider.of<MoviesProvider>(context, listen: false).setFav(movie);
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
      ),
    );
  }
}