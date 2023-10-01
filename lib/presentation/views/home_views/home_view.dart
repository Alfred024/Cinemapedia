import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingProvider.notifier).loadNextPage();
    ref.read(upcomingProvider.notifier).loadNextPage();
    ref.read(popularProvider.notifier).loadNextPage();
    ref.read(topRatedProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final firstLoad = ref.watch(firstLoaderProvider);

    if (firstLoad) return const FullScreenLoader();

    final moviesSlide = ref.watch(moviesSlideShowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingProvider);
    final popularMovies = ref.watch(popularProvider);
    final upcomigMovies = ref.watch(upcomingProvider);
    final topRatedMovies = ref.watch(topRatedProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppBar(),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate(
        childCount: 1,
        (context, index) {
          return Column(
            children: [
              MoviesSlideShow(movies: moviesSlide),
              MovieHorizontalListView(
                title: 'En cines',
                subTitle: 'Viernes 18',
                movies: nowPlayingMovies,
                loadNextPage: () =>
                    ref.read(nowPlayingProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListView(
                title: 'Proximamente',
                subTitle: 'En un mes',
                movies: upcomigMovies,
                loadNextPage: () =>
                    ref.read(upcomingProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListView(
                title: 'Popular',
                subTitle: '',
                movies: popularMovies,
                //movies: nowPlayingMovies,
                loadNextPage: () =>
                    ref.read(popularProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListView(
                title: 'Mejor calificadas',
                subTitle: '',
                movies: topRatedMovies,
                //movies: upcomigMovies,
                loadNextPage: () =>
                    ref.read(topRatedProvider.notifier).loadNextPage(),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        },
      )),
    ]);
  }
}
