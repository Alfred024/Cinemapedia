import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesDataSource moviesDataSource;

  MoviesRepositoryImpl(this.moviesDataSource);

  @override
  Future<List<Movie>> getNowPlay({int page = 1}) {
    return moviesDataSource.getNowPlay(page: page);
  }
}
