import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/core/domain/use_cases/movies_data.dart';
import 'package:movie_app/core/services/api_service.dart';
import 'package:movie_app/core/views/movies_page.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/domain/repositories/movie_repo_calls.dart';
import 'core/services/storage_service.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Load .env file
  await dotenv.load(fileName: ".env");

  // Instantiate Dio
  final dio = Dio();

  // Instantiate ApiService
  final apiService = ApiService(dio);

  // Instantiate Movies data source
  var localData = await SharedPreferences.getInstance();

  // Instantiate Movies Repository
  final movieRepo = MovieRepoCalls(api: apiService, storageService: StorageService(sharedPreferences: localData));

  // Instantiate Movies Provider
  final getPopularMovies = MoviesData(movieRepo);

  runApp(MyApp(getPopularMovies: getPopularMovies));
}

class MyApp extends StatelessWidget {

  final MoviesData getPopularMovies;

  const MyApp({Key? key, required this.getPopularMovies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MoviesProvider(getPopularMovies: getPopularMovies),
        child: MaterialApp(
          title: 'Movies App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MoviesPage(),
        )
    );
  }
}
