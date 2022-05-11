part of 'on_the_air_tvs_bloc.dart';

abstract class OnTheAirTvsState extends Equatable {
  const OnTheAirTvsState();

  @override
  List<Object> get props => [];
}

class OnTheAirTvEmpty extends OnTheAirTvsState {}

class OnTheAirTvLoading extends OnTheAirTvsState {}

class OnTheAirTvError extends OnTheAirTvsState {
  final String message;

  OnTheAirTvError(this.message);

  @override
  List<Object> get props => [message];
}

class OnTheAirTvHasData extends OnTheAirTvsState {
  final List<Tv> listTv;

  OnTheAirTvHasData(this.listTv);

  @override
  List<Object> get props => [listTv];
}
