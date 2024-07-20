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
          )
        ],
      ),
      body: FutureBuilder(
        future: moviesProvider.fetchPopular(),
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
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: moviesProvider.gridview ? 1 : 2,
                childAspectRatio: 2 / 3,
              ),
              itemCount: moviesProvider.popular.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: moviesProvider.popular[index]);
              },
            );
          }
        },
      )
    );
  }
}