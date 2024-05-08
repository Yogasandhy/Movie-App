import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_api/Detail/detailProvider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final int movieId;

  const DetailScreen({required this.movieId, Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool showFullOverview = false;

  @override
  void initState() {
    super.initState();
    Provider.of<DetailProvider>(context, listen: false)
        .fetchMovieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailProvider>(
        builder: (context, detailProvider, child) {
          final int runtime = detailProvider.movieDetail?.runtime ?? 0;
          final hours = runtime ~/ 60;
          final minutes = runtime % 60;
          final formattedRuntime = '$hours h $minutes m';

          String overview = detailProvider.movieDetail?.overview ?? '';

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${detailProvider.movieDetail?.posterPath}',
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 370,
                      ),
                    ),
                    SizedBox(height: 7),
                    Center(
                      child: Text(
                        detailProvider.movieDetail?.title ?? '',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          detailProvider.movieDetail?.genres
                                  ?.map((genre) => genre.name)
                                  .join(', ') ??
                              '',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.fiber_manual_record,
                          color: Colors.white,
                          size: 8,
                        ),
                        SizedBox(width: 8),
                        Text(
                          formattedRuntime,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    Text(
                      detailProvider.movieDetail?.releaseDate ?? '',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    'Play',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF31304D),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.download,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    'Download',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 7),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: showFullOverview
                                  ? overview
                                  : _truncateOverview(overview),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            if (!showFullOverview) ...[
                              TextSpan(
                                text: ' Read more',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    setState(() {
                                      showFullOverview = true;
                                    });
                                  },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TabBar(
                      tabs: [
                        Tab(text: 'Tab 1'),
                        Tab(text: 'Tab 2'),
                        Tab(text: 'Tab 3'),
                      ],
                    ),
                    SizedBox(
                      height: 200,
                      child: TabBarView(
                        children: [
                          ListView(
                            children: [
                              Container(
                                color: Colors.red,
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.blue,
                          ),
                          Container(
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _truncateOverview(String overview) {
    if (overview.length <= 200) {
      return overview;
    } else {
      return overview.substring(0, 200) + '...';
    }
  }
}
