// To parse this JSON data, do
//
//     final discoverAllTrendindinModel = discoverAllTrendindinModelFromJson(jsonString);

import 'dart:convert';

DiscoverAllTrendindinModel discoverAllTrendindinModelFromJson(String str) =>
    DiscoverAllTrendindinModel.fromJson(json.decode(str));

String discoverAllTrendindinModelToJson(DiscoverAllTrendindinModel data) =>
    json.encode(data.toJson());

class DiscoverAllTrendindinModel {
  final int? page;
  final List<Result>? results;

  const DiscoverAllTrendindinModel({
    required this.page,
    required this.results,
  });

  factory DiscoverAllTrendindinModel.fromJson(Map<String, dynamic> json) =>
      DiscoverAllTrendindinModel(
        page: json["page"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
  static const DiscoverAllTrendindinModel empty =
      DiscoverAllTrendindinModel(page: null, results: null);
}

class Result {
  final bool adult;
  final String backdropPath;
  final int id;
  final String name;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final String posterPath;
  final String mediaType;
  final List<int> genreIds;
  final double popularity;
  final DateTime firstAirDate;
  final double voteAverage;
  final int voteCount;
  final List<String> originCountry;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        name: json["name"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: json["media_type"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "name": name,
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaType,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "popularity": popularity,
        "first_air_date":
            "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
      };
}
