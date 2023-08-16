import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String theMovieDBKey =
      dotenv.env['THE_MOVIEDDB_KEY'] ?? 'No hay API key';
}
