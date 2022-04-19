import 'package:cached_network_image/cached_network_image.dart';
import 'search_page.dart';
import 'top_rated_tvs_page.dart';
import 'tv_detail_page.dart';
import '../provider/tv_provider/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/tv.dart';
import 'on_the_air_tvs_page.dart';
import 'popular_tvs_page.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/home-tv';

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TvListNotifier>(context, listen: false)
      ..fetchOnTheAirTvs()
      ..fetchPopularTvs()
      ..fetchTopRatedTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ditonton - Tv Show'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME,
                  arguments: false);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSubHeading(
                  title: 'On The Air',
                  onTap: () =>
                      Navigator.pushNamed(context, OnTheAirTvsPage.ROUTE_NAME),
                ),
                Consumer<TvListNotifier>(builder: (context, data, child) {
                  final state = data.onTheAirState;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TvList(data.onTheAirTvs);
                  } else {
                    return Text('Failed');
                  }
                }),
                _buildSubHeading(
                  title: 'Popular',
                  onTap: () =>
                      Navigator.pushNamed(context, PopularTvsPage.ROUTE_NAME),
                ),
                Consumer<TvListNotifier>(builder: (context, data, child) {
                  final state = data.popularTvsState;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TvList(data.popularTvs);
                  } else {
                    return Text('Failed');
                  }
                }),
                _buildSubHeading(
                  title: 'Top Rated',
                  onTap: () =>
                      Navigator.pushNamed(context, TopRatedTvsPage.ROUTE_NAME),
                ),
                Consumer<TvListNotifier>(builder: (context, data, child) {
                  final state = data.topRatedTvsState;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TvList(data.topRatedTvs);
                  } else {
                    return Text('Failed');
                  }
                }),
              ],
            ),
          )),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  TvList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                print(tv.id);
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}