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
  }

  @override
  Widget build(BuildContext context) {
    final moviesSlide = ref.watch(moviesSlideShowProvider);
    final moviesOnXPage = ref.watch(nowPlayingProvider);

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
                movies: moviesOnXPage,
                loadNextPage: () =>
                    ref.read(nowPlayingProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListView(
                title: 'Proximamente',
                subTitle: 'En un mes',
                movies: moviesOnXPage,
                loadNextPage: () =>
                    ref.read(nowPlayingProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListView(
                title: 'En cines',
                subTitle: 'Viernes 18',
                movies: moviesOnXPage,
                loadNextPage: () =>
                    ref.read(nowPlayingProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListView(
                title: 'En cines',
                subTitle: 'Viernes 18',
                movies: moviesOnXPage,
                loadNextPage: () =>
                    ref.read(nowPlayingProvider.notifier).loadNextPage(),
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
