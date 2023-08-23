import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_from_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MoviefromMovieDB moviefromMovieDB) => Movie(
        adult: moviefromMovieDB.adult,
        backdropPath: moviefromMovieDB.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500/${moviefromMovieDB.backdropPath}'
            : 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png',
        genreIds: moviefromMovieDB.genreIds
            .map((genreID) => genreID.toString())
            .toList(),
        id: moviefromMovieDB.id,
        originalLanguage: moviefromMovieDB.originalLanguage,
        originalTitle: moviefromMovieDB.originalTitle,
        overview: moviefromMovieDB.overview,
        popularity: moviefromMovieDB.popularity,
        posterPath: moviefromMovieDB.posterPath != ''
            ? 'https://image.tmdb.org/t/p/w500/${moviefromMovieDB.posterPath}'
            : 'no poster found',
        releaseDate: moviefromMovieDB.releaseDate,
        title: moviefromMovieDB.title,
        video: moviefromMovieDB.video,
        voteAverage: moviefromMovieDB.voteAverage,
        voteCount: moviefromMovieDB.voteCount,
      );

  static Movie movieDetailsToEntity(MovieDetails movie) => Movie(
        adult: movie.adult,
        backdropPath: movie.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500/${movie.backdropPath}'
            : 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png',
        genreIds: movie.genres.map((genreID) => genreID.name).toList(),
        id: movie.id,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        overview: movie.overview,
        popularity: movie.popularity,
        posterPath: movie.posterPath != ''
            ? 'https://image.tmdb.org/t/p/w500/${movie.posterPath}'
            : 'no poster found',
        releaseDate: movie.releaseDate,
        title: movie.title,
        video: movie.video,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
      );
}
