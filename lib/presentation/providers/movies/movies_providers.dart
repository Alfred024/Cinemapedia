import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/movies.dart';

//Al state notifier le indicamos el notifier que controla su estado
//y la clase de dato que va a cambiar
final nowPlayingProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlay;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

//Ya que queremos que el MoviesNotifier no dependa de una provedor
//específico, creamos un tipo de dato genérico.
typedef MovieCallback = Future<List<Movie>> Function({int page});

//El StateNotifier necesita saber el tipo de estado que manejará
class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
  }
}
