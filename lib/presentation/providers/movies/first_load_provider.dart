import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firstLoaderProvider = Provider((ref) {
  Future.delayed(const Duration(seconds: 2));
  final npMoviesLoading = ref.watch(nowPlayingProvider).isEmpty;
  //final pMoviesLoading = ref.watch(popularProvider).isEmpty;
  final uMoviesLoading = ref.watch(upcomingProvider).isEmpty;
  //final trMoviesLoading = ref.watch(topRatedProvider).isEmpty;

  if (npMoviesLoading || uMoviesLoading) {
    return true;
  }
  return false;
});
