import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/movie.dart';

final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingProvider);
  if (nowPlayingMovies.isEmpty) return [];
  return nowPlayingMovies.sublist(0, 6);
});
