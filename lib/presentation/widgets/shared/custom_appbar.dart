import 'package:cinemapedia/presentation/delegates/search_delegate_movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movies.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final texts = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie,
                color: colors.primary,
              ),
              Text(
                'Cinemapedia',
                style: texts,
              ),
              const Spacer(),
              IconButton(
                  color: colors.primary,
                  onPressed: () {
                    final moviesRepository = ref.read(movieRepositoryProvider);
                    final searchQuery = ref.read(searchQueryProvider);

                    showSearch<Movie?>(
                            query: searchQuery,
                            context: context,
                            delegate: SearchMovieDelegate(
                                searchedMovies: ref
                                    .read(searchedMoviesProvider.notifier)
                                    .searchMoviesByQuery))
                        .then((movie) {
                      if (movie == null) {
                        return;
                        context.push('/movie/${movie?.id}');
                      }
                    });
                    //print(movie?.title);
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
        ),
      ),
    );
  }
}
