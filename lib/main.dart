import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/core/services/api_service.dart';
import 'package:movie_app/core/views/movies_page.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

  final dio = Dio();
  final api = ApiService(dio);

  runApp(MyApp(api: api));
}

class MyApp extends StatelessWidget {
  final ApiService api;

  const MyApp({super.key, required this.api});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MoviesProvider(api: api),
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
