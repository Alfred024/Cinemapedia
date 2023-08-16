import 'package:cinemapedia/domain/entities/movies.dart';

abstract class MoviesRepository {
  @override
  Future<List<Movie>> getNowPlay({int page = 1});
}
