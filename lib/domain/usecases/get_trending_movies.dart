import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';

class GetTrendingMovies {
  final MovieRepository movieRepository;

  GetTrendingMovies(this.movieRepository);

  Future<List<Movie>> call() async {
    return movieRepository.getTrendingMovies();
  }
}
