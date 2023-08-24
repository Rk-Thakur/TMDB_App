import 'package:equatable/equatable.dart';
import 'package:tmdb_app/features/discover_screen/model/discover_movie_model.dart';
import 'package:tmdb_app/features/discover_screen/repository/discover_repository.dart';
import 'package:bloc/bloc.dart';

import '../../search_screen/model/search_model.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final DiscoverRepository discoverRepository = DiscoverRepository();
  DiscoverBloc() : super(const DiscoverState()) {
    on<FetchPopularEvent>(_fetchPopularMovie);
    on<FetchNowPlayingEvent>(_fetchNowPlaying);
    on<FetchTopRatedEvent>(_fetchTopRated);
    on<FetchUpcomingEvent>(_fetchUpcoming);
    on<FetchSearchEvent>(_searchMovie);
  }

  void _fetchPopularMovie(FetchPopularEvent event, Emitter<DiscoverState> emit) async {
    try {
      emit(state.copyWith(popularStatus: PopularStatus.loading));
      final response = await discoverRepository.fetchPopular();
      emit(state.copyWith(popularStatus: PopularStatus.success, popularMovieModel: response));
    } catch (e) {
      emit(state.copyWith(popularStatus: PopularStatus.failure, message: e.toString()));
    }
  }

  void _fetchNowPlaying(FetchNowPlayingEvent event, Emitter<DiscoverState> emit) async {
    try {
      emit(state.copyWith(popularStatus: PopularStatus.loading));
      final response = await discoverRepository.fetchNowPlaying();
      emit(state.copyWith(popularStatus: PopularStatus.success, popularMovieModel: response));
    } catch (e) {
      emit(state.copyWith(popularStatus: PopularStatus.failure, message: e.toString()));
    }
  }

  void _fetchTopRated(FetchTopRatedEvent event, Emitter<DiscoverState> emit) async {
    try {
      emit(state.copyWith(popularStatus: PopularStatus.loading));
      final response = await discoverRepository.fetchTopRated();
      emit(state.copyWith(popularStatus: PopularStatus.success, popularMovieModel: response));
    } catch (e) {
      emit(state.copyWith(popularStatus: PopularStatus.failure, message: e.toString()));
    }
  }

  void _fetchUpcoming(FetchUpcomingEvent event, Emitter<DiscoverState> emit) async {
    try {
      emit(state.copyWith(popularStatus: PopularStatus.loading));
      final response = await discoverRepository.fetchUpComing();
      emit(state.copyWith(popularStatus: PopularStatus.success, popularMovieModel: response));
    } catch (e) {
      emit(state.copyWith(popularStatus: PopularStatus.failure, message: e.toString()));
    }
  }

  void _searchMovie(FetchSearchEvent event, Emitter<DiscoverState> emit) async {
    try {
      emit(state.copyWith(popularStatus: PopularStatus.loading));
      print(state.popularStatus);
      final response = await discoverRepository.searchMovies(event.query);
      emit(state.copyWith(popularStatus: PopularStatus.success, searcModel: response));
            print(state.popularStatus);

    } catch (e) {
      emit(state.copyWith(popularStatus: PopularStatus.failure, message: e.toString()));
    }
  }
}
