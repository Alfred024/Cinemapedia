import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MovieDBdatasource extends MoviesDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDBKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Movie>> getNowPlay({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });
    final movieDBresponse = MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = movieDBresponse.results
        .where((movie) => movie.posterPath != 'no poster found')
        .map((movie) => MovieMapper.movieDBToEntity(movie))
        .toList();
    return movies;
  }
}
