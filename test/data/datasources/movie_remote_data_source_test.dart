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
const sampleApiResponse = '''{
  "page": 1,
  "results": [
    {
      "backdrop_path": "/rbEsJL59iW5mr4s1YnLocEFdO3Q.jpg",
      "id": 748167,
      "title": "Uglies",
      "original_title": "Uglies",
      "overview":
          "In a futuristic dystopia with enforced beauty standards, a teen awaiting mandatory cosmetic surgery embarks on a journey to find her missing friend.",
      "poster_path": "/og1SH6we0UQx5XNIDSfxDD4S1Sp.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [878, 18, 12],
      "popularity": 70.3,
      "release_date": "2024-09-12",
      "video": false,
      "vote_average": 5.636,
      "vote_count": 22
    },
    {
      "backdrop_path": "/Asg2UUwipAdE87MxtJy7SQo08XI.jpg",
      "id": 957452,
      "title": "The Crow",
      "original_title": "The Crow",
      "overview":
          "Soulmates Eric and Shelly are brutally murdered when the demons of her dark past catch up with them. Given the chance to save his true love by sacrificing himself, Eric sets out to seek merciless revenge on their killers, traversing the worlds of the living and the dead to put the wrong things right.",
      "poster_path": "/AqchrmqqSCsEvhuinXgFXTD8q83.jpg",
      "media_type": "movie",
      "adult": false,
      "original_language": "en",
      "genre_ids": [28, 14, 53],
      "popularity": 140.556,
      "release_date": "2024-08-21",
      "video": false,
      "vote_average": 5.325,
      "vote_count": 137
    }
  ]
}''';

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
