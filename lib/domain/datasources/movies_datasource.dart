import 'package:cinemapedia/domain/entities/movies.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getNowPlay({int page = 1});
}
