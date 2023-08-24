import 'package:dio/dio.dart';
import 'package:tmdb_app/core/api/endpoints.dart';
import 'package:tmdb_app/features/discover_screen/model/discover_movie_model.dart';

import '../../search_screen/model/search_model.dart';

class DiscoverRepository {
  final dio = Dio();

  Future<DiscoverMovieModel> fetchPopular() async {
    try {
      final response = await dio.get(EndPoints.popularMoviesUrl());
      return DiscoverMovieModel.fromJson(response.data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<DiscoverMovieModel> fetchNowPlaying() async {
    try {
      final response = await dio.get(EndPoints.nowPlayingMoviesUrl());
      return DiscoverMovieModel.fromJson(response.data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<DiscoverMovieModel> fetchTopRated() async {
    try {
      final response = await dio.get(EndPoints.topRatedMoviesUrl());
      return DiscoverMovieModel.fromJson(response.data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<DiscoverMovieModel> fetchUpComing() async {
    try {
      final response = await dio.get(EndPoints.upComingMoviesUrl());
      return DiscoverMovieModel.fromJson(response.data);
    } catch (e) {
      throw e.toString();
    }
  }



  Future<SearcModel> searchMovies(String query) async {
    try {
      final response = await dio.get(EndPoints.movieSearchUrl(query));
      return SearcModel.fromJson(response.data);
    } catch (e) {
      throw e.toString();
    }
  }
}
