import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_movies_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc =
        NowPlayingMoviesBloc(getNowPlayingMovies: mockGetNowPlayingMovies);
  });

  test('initial state should be empty', () {
    expect(nowPlayingMoviesBloc.state, NowPlayingMovieEmpty());
  });

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
          ..thenAnswer((_) async => Right(testMovieList));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      expect: () => [
            NowPlayingMovieLoading(),
            NowPlayingMovieHasData(testMovieList),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      });

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, Error] when data is gotten failed',
      build: () {
        when(mockGetNowPlayingMovies.execute())
          ..thenAnswer((_) async => Left(ServerFailure('Failed')));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      expect: () => [
            NowPlayingMovieLoading(),
            NowPlayingMovieError('Failed'),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      });
}