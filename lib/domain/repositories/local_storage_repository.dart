import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageRepository {
  Future<bool> isMovieFavourite(int movieId);

  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});

  Future<void> toggleFavourites(Movie movie);
}
