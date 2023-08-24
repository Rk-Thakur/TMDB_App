import 'package:dio/dio.dart';
import 'package:tmdb_app/core/api/endpoints.dart';

import '../model/search_model.dart';

class SearchRepository {
  final dio = Dio();

  Future<SearcModel> fetchSeachedMovie(String query) async {
    try {
      final response = await dio.get(EndPoints.movieSearchUrl(query));
      return SearcModel.fromJson(response.data);
    } catch (e) {
      throw e.toString();
    }
  }
}
