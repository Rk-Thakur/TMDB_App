import 'package:dio/dio.dart';
import 'package:tmdb_app/core/api/endpoints.dart';
import 'package:tmdb_app/features/detail_screen/model/detail_movie_model.dart';


class DetailRepostiory {
  final dio = Dio();
  Future<MovieDetailModel> getMovieDetails(int movieId) async {
    try {
      final response = await dio.get(EndPoints.movieDetails(movieId));
      print(response.data);
      return MovieDetailModel.fromJson(response.data);
    } catch (e) {
      throw e.toString();
    }
  }


}
