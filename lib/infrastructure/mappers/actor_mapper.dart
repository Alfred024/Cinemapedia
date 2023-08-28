import 'package:cinemapedia/domain/entities/actor.dart';
import '../models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToActor(Cast cast) => Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
          : 'https://w7.pngwing.com/pngs/442/477/png-transparent-computer-icons-user-profile-avatar-profile-heroes-profile-user.png',
      charachter: cast.character);
}
