import 'package:cinemapedia/domain/entities/movies.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getNowPlay({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<Movie> getMovieByID(String id);
  Future<List<Movie>> searchMovie(String query);
}
