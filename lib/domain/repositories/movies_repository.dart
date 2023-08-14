import 'package:cinemapedia/domain/entities/movies.dart';

abstract class MovieDataSource {
  Future<List<Movie>> getNowPlay({int page = 1});
}
