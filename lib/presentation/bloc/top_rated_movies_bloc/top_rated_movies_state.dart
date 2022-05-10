part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class TopRatedMoviesEmpty extends TopRatedMoviesState {}

class TopRatedMoviesLoading extends TopRatedMoviesState {}

class TopRatedMoviesError extends TopRatedMoviesState {
  final String message;

  TopRatedMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedMoviesHasData extends TopRatedMoviesState {
  final List<Movie> listMovie;

  TopRatedMoviesHasData(this.listMovie);

  @override
  List<Object> get props => [listMovie];
}
