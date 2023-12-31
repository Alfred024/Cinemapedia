import 'package:animate_do/animate_do.dart';
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
        pagination: const SwiperPagination(
            margin: EdgeInsets.only(top: 10),
            builder: DotSwiperPaginationBuilder(
                color: Color.fromARGB(255, 86, 86, 86))),
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
    final slideDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Color.fromARGB(255, 240, 203, 200),
              blurRadius: 10,
              offset: Offset(-5, -5))
        ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 20),
      child: DecoratedBox(
        decoration: slideDecoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(movie.backdropPath, fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return const CircularProgressIndicator(
                color: Colors.red,
                strokeWidth: 2.0,
              );
            } else {
              return FadeIn(child: child);
            }
          }),
        ),
      ),
    );
  }
}
