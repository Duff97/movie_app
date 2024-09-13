import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:movie_app/domain/entities/movie.entity.dart';
import 'package:movie_app/domain/repositories/movie.repository.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/domain/usecases/search_movies.usecase.dart';

import 'get_trending_movies.test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])
void main() {
  late SearchMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  final tMoviesList = [
    Movie(
        id: 1,
        title: "Test Movie 1",
        overview: "Desc 1",
        posterPath: "/image1"),
    Movie(
        id: 2,
        title: "Test Movie 2",
        overview: "Desc 2",
        posterPath: "/image2"),
  ];

  const tQuery = 'Inception';

  test('should get movies from the query from the repository', () async {
    // arrange
    when(mockMovieRepository.searchMovies(any))
        .thenAnswer((_) async => tMoviesList);
    // act
    final result = await usecase(tQuery);
    // assert
    expect(result, tMoviesList);
    verify(mockMovieRepository.searchMovies(tQuery));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
