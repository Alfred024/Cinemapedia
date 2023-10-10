import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MovieDBdatasource extends MoviesDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDBKey,
        'language': 'es-MX'
      }));

  List<Movie> moviesFetched(Map<String, dynamic> response) {
    final movieDBresponse = MovieDbResponse.fromJson(response);
    final List<Movie> movies = movieDBresponse.results
        .where((movie) => movie.posterPath != 'no poster found')
        .map((movie) => MovieMapper.movieDBToEntity(movie))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlay({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });
    return moviesFetched(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: {
      'page': page,
    });
    return moviesFetched(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', queryParameters: {
      'page': page,
    });
    return moviesFetched(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: {
      'page': page,
    });
    return moviesFetched(response.data);
  }

  @override
  Future<Movie> getMovieByID(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) {
      throw Exception('Movie of $id was not found');
    }

    final movieDetails = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }

  @override
  Future<List<Movie>> searchMovie(String query) async {
    if (query.isNotEmpty) {
      final response = await dio.get('/search/movie', queryParameters: {
        'query': query,
      });
      return moviesFetched(response.data);
    } else {
      return [];
    }
  }
}
