// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'seach_bloc.dart';

sealed class SeachEvent extends Equatable {
  const SeachEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class SearchingEvent extends SeachEvent {
  String query;
  SearchingEvent({
    required this.query,
  });
}
