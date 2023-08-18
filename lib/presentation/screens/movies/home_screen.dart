import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class HomeScreen extends ConsumerWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  __HomeViewState createState() => __HomeViewState();
}

class __HomeViewState extends ConsumerState<_HomeView> {
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
                loadNextPage: () =>
                    ref.read(popularProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListView(
                title: 'Mejor calificadas',
                subTitle: '',
                movies: topRatedMovies,
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
