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

  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchDataFuture = _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    await moviesProvider.fetchData();
  }

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            icon: Icon(moviesProvider.gridview ? Icons.list : Icons.grid_view),
            onPressed: () {
              moviesProvider.changeView();
            },
          ),
          IconButton(
            icon: Icon(moviesProvider.isPopular ? Icons.star : Icons.play_arrow),
            onPressed: () {
              moviesProvider.changeData();
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _fetchDataFuture,
        builder: (context, snapshot) {
          if (moviesProvider.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (moviesProvider.errorMessage.isNotEmpty) {
            return Center(
              child: Text(moviesProvider.errorMessage),
            );
          } else {
            return moviesProvider.gridview ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
              ),
              itemCount: moviesProvider.popular.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: moviesProvider.popular[index]);
              },
            )
            : ListView.builder(
              itemCount: moviesProvider.popular.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 400,
                    child: MovieCard(movie: moviesProvider.popular[index]),
                );
              },
            );
          }
        },
      )
    );
  }
}