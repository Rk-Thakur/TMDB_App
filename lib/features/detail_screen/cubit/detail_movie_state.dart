// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_movie_cubit.dart';

enum DetailStatus { initial, loading, success, failure }

class DetailMovieState extends Equatable {
  final DetailStatus detailStatus;
  final MovieDetailModel movieDetailModel;
  final String message;
  const DetailMovieState({
    this.detailStatus = DetailStatus.initial,
    this.movieDetailModel = MovieDetailModel.empty,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        detailStatus,
        movieDetailModel,
      ];

  DetailMovieState copyWith({
    DetailStatus? detailStatus,
    MovieDetailModel? movieDetailModel,
    String? message,
  }) {
    return DetailMovieState(
      detailStatus: detailStatus ?? this.detailStatus,
      movieDetailModel: movieDetailModel ?? this.movieDetailModel,
      message: message ?? this.message,
    );
  }
}
