part of 'tv_season_bloc.dart';

abstract class TvSeasonEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTvSeason extends TvSeasonEvent {
  final int id;
  final int seasonNumber;

  FetchTvSeason(this.id, this.seasonNumber);

  @override
  List<Object> get props => [id, seasonNumber];
}
