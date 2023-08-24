import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoints {
  static String popularMoviesUrl() {
    return '${dotenv.env['BASE_URL']}'
        '/movie/popular?api_key='
        '${dotenv.env['API_KEY']}'
        '&language=en-US&page=1';
  }

  static String nowPlayingMoviesUrl() {
    return '${dotenv.env['BASE_URL']}'
        '/movie/now_playing?api_key='
        '${dotenv.env['API_KEY']}'
        '&language=en-US&page=1';
  }

  static String topRatedMoviesUrl() {
    return '${dotenv.env['BASE_URL']}'
        '/movie/top_rated?api_key='
        '${dotenv.env['API_KEY']}'
        '&language=en-US&page=1';
  }

  static String upComingMoviesUrl() {
    return '${dotenv.env['BASE_URL']}'
        '/movie/upcoming?api_key='
        '${dotenv.env['API_KEY']}'
        '&language=en-US&page=1';
  }

  static String allTrendingUrl() {
    return 'https://api.themoviedb.org/3/trending/all/day?api_key='
        '${dotenv.env['API_KEY']}'
        '&language=en-US&page=1';
  }

  static String movieDetails(int movieId) {
    return '${dotenv.env['BASE_URL']}'
        '/movie/$movieId?api_key='
        '${dotenv.env['API_KEY']}';
  }

  static String movieSearchUrl(String query) {
    return '${dotenv.env['BASE_URL']}'
        '/search/movie?api_key='
        '${dotenv.env['API_KEY']}'
        '&query=$query&page=1';
  }

  static String similarMovie(int movieId) {
    return '${dotenv.env['BASE_URL']}'
        '/movie/$movieId/similar?api_key='
        '${dotenv.env['API_KEY']}'
        '&page=1';
  }
}
