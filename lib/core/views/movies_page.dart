import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:movie_app/ui/movie_card.dart';
import 'package:provider/provider.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MoviesProvider>(context, listen: false).fetchPopularMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_on),
            onPressed: () {
              Provider.of<MoviesProvider>(context, listen: false).toggleView();
            },
          ),
        ],
      ),
      body: Consumer<MoviesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return provider.gridView ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: provider.movies.length,
            itemBuilder: (context, index) {
              return MovieCard(movie: provider.movies[index]);
            },
          )
          :
          ListView.builder(
            itemCount: provider.movies.length,
            itemBuilder: (context, index) {
              return MovieCard(movie: provider.movies[index]);
            },
          );
        },
      ),
    );
  }
}