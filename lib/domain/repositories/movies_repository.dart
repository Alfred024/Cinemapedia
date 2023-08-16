import 'package:cinemapedia/domain/entities/movies.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlay({int page = 1});
}
