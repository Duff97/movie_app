import 'package:movie_app/domain/entities/movie.entity.dart';
import 'package:movie_app/domain/repositories/movie.repository.dart';

class GetPopularMovies {
  final MovieRepository movieRepository;

  GetPopularMovies(this.movieRepository);

  Future<List<Movie>> call() async {
    return movieRepository.getPopularMovies();
  }
}
