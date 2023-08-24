// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'discover_bloc.dart';

abstract class DiscoverEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPopularEvent extends DiscoverEvent {}

class FetchNowPlayingEvent extends DiscoverEvent {}

class FetchTopRatedEvent extends DiscoverEvent {}

class FetchUpcomingEvent extends DiscoverEvent {}

class FetchAllTrendinEvent extends DiscoverEvent {}

// ignore: must_be_immutable
class FetchSearchEvent extends DiscoverEvent {
  String query;
  FetchSearchEvent({
    required this.query,
  });
}
