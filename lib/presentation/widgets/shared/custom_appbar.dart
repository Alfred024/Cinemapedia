import 'package:cinemapedia/presentation/delegates/search_delegate_movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                    showSearch(
                        context: context,
                        delegate: SearchMovieDelegate(
                            searchedMovies: moviesRepository.searchMovie));
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
        ),
      ),
    );
  }
}
