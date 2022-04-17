import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/season.dart';
import '../entities/tv_season.dart';
import '../../common/failure.dart';
import '../entities/tv.dart';
import '../entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getOnTheAirTvs();
  Future<Either<Failure, List<Tv>>> getPopularTvs();
  Future<Either<Failure, List<Tv>>> getTopRatedTvs();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecomendations(int id);
  Future<Either<Failure, List<Tv>>> searchTv(String query);
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tv);
  Future<bool> isTvAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTvs();
  Future<Either<Failure, List<TvSeason>>> getTvSeasons(int tvId, List<Season> seasons);
}
