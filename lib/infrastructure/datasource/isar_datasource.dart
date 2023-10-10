import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class IsarDatasource extends LocalStorageDatasource {

  late Future<Isar> db;

  IsarDataSource(){
    db = openDB();
  }

  Future<Isar> openDB() async{
    final dir = await getApplicationDocumentsDirectory();

    if( Isar.instanceNames.isEmpty ){
      return await Isar.open(
        [ MovieSchema ],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavourite(int movieId) {
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavourites(Movie movie) {
    throw UnimplementedError();
  }
}
