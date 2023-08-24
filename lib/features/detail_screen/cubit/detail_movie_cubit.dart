import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_app/features/detail_screen/model/detail_movie_model.dart';
import 'package:tmdb_app/features/detail_screen/repository/detail_repository.dart';

part 'detail_movie_state.dart';

class DetailMovieCubit extends Cubit<DetailMovieState> {
  DetailMovieCubit() : super(const DetailMovieState());
  final DetailRepostiory detailRepostiory = DetailRepostiory();
  void getMovieDetails(int movieId) async {
    try {
      emit(state.copyWith(detailStatus: DetailStatus.loading));
      final result = await detailRepostiory.getMovieDetails(movieId);
      emit(state.copyWith(detailStatus: DetailStatus.success, movieDetailModel: result));
    } catch (e) {
      emit(state.copyWith(detailStatus: DetailStatus.failure, message: e.toString()));
    }
  }
}
