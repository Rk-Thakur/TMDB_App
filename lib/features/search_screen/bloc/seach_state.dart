// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'seach_bloc.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  final SearchStatus searchStatus;
  final SearcModel searcModel;
  final String message;
  const SearchState({
    this.searchStatus = SearchStatus.initial,
    this.searcModel = SearcModel.empty,
    this.message = '',
  });
  @override
  // TODO: implement props
  List<Object?> get props => [searcModel, searchStatus, message];

  SearchState copyWith({
    SearchStatus? searchStatus,
    SearcModel? searcModel,
    String? message,
  }) {
    return SearchState(
      searchStatus: searchStatus ?? this.searchStatus,
      searcModel: searcModel ?? this.searcModel,
      message: message ?? this.message,
    );
  }
}
