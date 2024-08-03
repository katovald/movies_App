import 'package:movie_app/core/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences sharedPreferences;

  StorageService({required this.sharedPreferences});

  Future<void> addRemoveFav(Movie movie) async {
    await sharedPreferences.setStringList('favorites', []);
  }

  Future<void> saveFavorites() async {
    // save favorites to local storage
    sharedPreferences.setStringList('favorites', []);
  }

  Future<void> loadFavorites() async {
    sharedPreferences.getStringList('favorites') ?? [];
  }

  Future<void> clearSF() async {
    await sharedPreferences.clear();
  }


}