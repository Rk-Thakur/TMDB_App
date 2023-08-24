import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_app/features/search_screen/model/search_model.dart';
import 'package:tmdb_app/features/search_screen/repository/search_repository.dart';

part 'seach_event.dart';
part 'seach_state.dart';

class SeachBloc extends Bloc<SeachEvent, SearchState> {
  final SearchRepository searchRepository = SearchRepository();
  SeachBloc() : super(const SearchState()) {
    on<SearchingEvent>((event, emit) async {
      try {
        emit(state.copyWith(searchStatus: SearchStatus.loading));
        final response = await searchRepository.fetchSeachedMovie(event.query);
        print(response);
        emit(state.copyWith(searchStatus: SearchStatus.success, searcModel: response));
      } catch (e) {
        emit(state.copyWith(searchStatus: SearchStatus.failure, message: e.toString()));
      }
    });
  }
}
