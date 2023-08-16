import 'package:cinemapedia/domain/entities/movies.dart';
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
}
