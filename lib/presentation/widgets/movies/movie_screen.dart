import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_by_movie_provider.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: 1,
                  (context, index) => _MovieDetails(movie: movie))),
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                width: size.width * 0.3,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: ((size.width) * 0.7) - 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyles.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(movie.overview),
                ],
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(gender),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),
        ActorsByMovie(
          movieId: movie.id.toString(),
        ),
        const SizedBox(
          height: 150,
        )
      ],
    );
  }
}

final isFavouriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavourite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavouriteFuture = ref.watch(isFavouriteProvider(movie.id));

    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      ),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {
            ref.read(localStorageRepositoryProvider).toggleFavourites(movie);
            ref.invalidate(isFavouriteProvider(movie.id));
          },
          icon: isFavouriteFuture.when(
            loading: () => const CircularProgressIndicator(
              strokeWidth: 2,
            ),
            data: (isFavourite) => isFavourite
                ? const Icon(
                    Icons.favorite_rounded,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.favorite_border_rounded,
                    color: Colors.white,
                  ),
            error: (_, __) => throw UnimplementedError(),
          ),
        )
      ],
      expandedHeight: size.height * 0.60,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(12),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                scale: 0.5,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),

            //Top gradient
            const _CustomGradient(
                beginAlignment: Alignment.topLeft,
                endAlignment: Alignment.bottomLeft,
                stopsA: 0.0,
                stopsB: 0.3,
                colorA: Colors.black87,
                colorB: Colors.transparent),

            //Right gradient
            // const _CustomGradient(
            //     beginAlignment: Alignment.topRight,
            //     endAlignment: Alignment.bottomLeft,
            //     stopsA: 0.0,
            //     stopsB: 0.2,
            //     colorA: Colors.black87,
            //     colorB: Colors.transparent),

            //Bottom gradient
            const _CustomGradient(
                beginAlignment: Alignment.topCenter,
                endAlignment: Alignment.bottomCenter,
                stopsA: 0.7,
                stopsB: 1.0,
                colorA: Colors.transparent,
                colorB: Colors.black87)
          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final Alignment beginAlignment;
  final Alignment endAlignment;
  final double stopsA, stopsB;
  final Color colorA, colorB;

  const _CustomGradient(
      {required this.beginAlignment,
      required this.endAlignment,
      required this.stopsA,
      required this.stopsB,
      required this.colorA,
      required this.colorB});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: beginAlignment,
                  end: endAlignment,
                  stops: [
            stopsA,
            stopsB,
          ],
                  colors: [
            colorA,
            colorB,
          ]))),
    );
  }
}

class ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const ActorsByMovie({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider)[movieId];
    if (actorsByMovie == null) {
      return const CircularProgressIndicator(
        strokeWidth: 2,
      );
    }
    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actorsByMovie.length,
          itemBuilder: (context, index) {
            final actor = actorsByMovie[index];

            return Container(
              padding: const EdgeInsets.all(8.0),
              width: 135,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    actor.name,
                    maxLines: 2,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                  Text(
                    actor.charachter ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
