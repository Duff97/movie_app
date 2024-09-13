import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/core/errors/server_exception.dart';
import 'package:movie_app/data/datasources/remote/movie_remote_data_source_impl.dart';
import 'package:movie_app/data/datasources/movie_remote_data_source.dart';

import 'movie_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
const sampleApiResponse = '''[
  {
    "id": 748167,
    "title": "Uglies",
    "overview":
        "In a futuristic dystopia with enforced beauty standards, a teen awaiting mandatory cosmetic surgery embarks on a journey to find her missing friend.",
    "poster_path": "/og1SH6we0UQx5XNIDSfxDD4S1Sp.jpg",
  },
  {
    "id": 957452,
    "title": "The Crow",
    "overview":
        "Soulmates Eric and Shelly are brutally murdered when the demons of her dark past catch up with them. Given the chance to save his true love by sacrificing himself, Eric sets out to seek merciless revenge on their killers, traversing the worlds of the living and the dead to put the wrong things right.",
    "poster_path": "/AqchrmqqSCsEvhuinXgFXTD8q83.jpg",
  }
]''';

void main() {
  late MovieRemoteDataSource dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  test('should perform a GET request on a url to get tending movies', () async {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(sampleApiResponse, 200));

    await dataSource.getTrendingMovies();

    verify(mockHttpClient.get(Uri.parse(Constants.baseUrl)));
  });

  test('should throw ServerException when response code is 404', () async {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));

    final call = dataSource.getTrendingMovies;

    expect(() => call(), throwsA(isA<ServerException>()));
  });
}
