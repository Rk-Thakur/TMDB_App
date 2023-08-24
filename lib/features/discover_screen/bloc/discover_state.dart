// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'discover_bloc.dart';

enum PopularStatus { initial, loading, success, failure }

enum AllStatus { initial, loading, success, failure }

class DiscoverState extends Equatable {
  final PopularStatus popularStatus;
  final DiscoverMovieModel popularMovieModel;
  final String message;
  final SearcModel searcModel;
  const DiscoverState(
      {this.popularStatus = PopularStatus.initial,
      this.popularMovieModel = DiscoverMovieModel.empty,
      this.message = '',
      this.searcModel = SearcModel.empty});

  DiscoverState copyWith({
    PopularStatus? popularStatus,
    DiscoverMovieModel? popularMovieModel,
    String? message,
    AllStatus? allStatus,
    SearcModel? searcModel,
  }) {
    return DiscoverState(
      popularStatus: popularStatus ?? this.popularStatus,
      popularMovieModel: popularMovieModel ?? this.popularMovieModel,
      message: message ?? this.message,
      searcModel: searcModel ?? this.searcModel,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [popularStatus, popularMovieModel, message, searcModel];
}
