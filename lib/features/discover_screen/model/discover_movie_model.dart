// To parse this JSON data, do
//
//     final popularMovieModel = popularMovieModelFromJson(jsonString);

import 'dart:convert';

DiscoverMovieModel popularMovieModelFromJson(String str) =>
    DiscoverMovieModel.fromJson(json.decode(str));

String popularMovieModelToJson(DiscoverMovieModel data) => json.encode(data.toJson());

class DiscoverMovieModel {
  final int? page;
  final List<Result>? results;

  const DiscoverMovieModel({
    required this.page,
    required this.results,
  });

  factory DiscoverMovieModel.fromJson(Map<String, dynamic> json) => DiscoverMovieModel(
        page: json["page"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
  static const DiscoverMovieModel empty = DiscoverMovieModel(page: null, results: null);
}

class Result {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
