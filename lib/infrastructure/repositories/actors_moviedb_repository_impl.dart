import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorsMovieDbRepository extends ActorsRepository {
  final ActorsDataSource actors;

  ActorsMovieDbRepository({required this.actors});

  @override
  Future<List<Actor>> getActorsByMovie(String movieID) {
    return actors.getActorsByMovie(movieID);
  }
}
