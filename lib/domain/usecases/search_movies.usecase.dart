import 'package:movie_app/domain/entities/movie.entity.dart';
import 'package:movie_app/domain/repositories/movie.repository.dart';

class SearchMovies {
  final MovieRepository movieRepository;

  SearchMovies(this.movieRepository);

  Future<List<Movie>> call(String query) async {
    return movieRepository.searchMovies(query);
  }
}
