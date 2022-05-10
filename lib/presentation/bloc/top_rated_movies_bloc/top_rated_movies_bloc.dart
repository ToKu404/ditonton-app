import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/movie_usecase/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies topRatedMovies;

  TopRatedMoviesBloc({required this.topRatedMovies})
      : super(TopRatedMoviesEmpty()) {
    on<FetchTopRatedMovies>(((event, emit) async {
      emit(TopRatedMoviesLoading());
      final result = await topRatedMovies.execute();
      result.fold(
        (failure) => emit(TopRatedMoviesError(failure.message)),
        (movies) => emit(TopRatedMoviesHasData(movies)),
      );
    }));
  }
}
