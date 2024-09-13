import 'dart:convert';
import 'dart:core';

import 'package:movie_app/constants.dart';
import 'package:movie_app/core/errors/server_exception.dart';
import 'package:movie_app/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/data/models/movie.model.dart';
import 'package:http/http.dart' as http;

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await client.get(Uri.parse(
        "${Constants.baseUrl}/movie/popular?api_key=${Constants.apiKey}"));

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final responseBody = json.decode(response.body);
    final List<MovieModel> movies = (responseBody['results'] as List)
        .map((movie) => MovieModel.fromjson(movie))
        .toList();
    return movies;
  }

  @override
  Future<List<MovieModel>> getTrendingMovies() async {
    final response = await client.get(Uri.parse(
        "${Constants.baseUrl}/trending/movie/day?api_key=${Constants.apiKey}"));

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final responseBody = json.decode(response.body);
    final List<MovieModel> movies = (responseBody['results'] as List)
        .map((movie) => MovieModel.fromjson(movie))
        .toList();
    return movies;
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client.get(Uri.parse(
        "${Constants.baseUrl}/movie/popular?api_key=${Constants.apiKey}"));

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final responseBody = json.decode(response.body);
    final List<MovieModel> movies = (responseBody['results'] as List)
        .map((movie) => MovieModel.fromjson(movie))
        .toList();
    return movies;
  }
}
