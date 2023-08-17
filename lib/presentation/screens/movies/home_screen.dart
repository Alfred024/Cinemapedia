import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: _HomeView(),
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
    final moviesOnXPage = ref.watch(nowPlayingProvider);

    return Column(children: [
      const CustomAppBar(),
      Expanded(
          child: ListView.builder(
        itemCount: moviesOnXPage.length,
        itemBuilder: (context, index) {
          return Text(moviesOnXPage[index].posterPath);
        },
      )),
    ]);
  }
}
