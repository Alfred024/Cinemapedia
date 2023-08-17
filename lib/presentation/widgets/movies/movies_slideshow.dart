import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:flutter/material.dart';

class MoviesSlideShow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlideShow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        scale: 0.9,
        viewportFraction: 0.8,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _Slide(
            movie: movie,
          );
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
