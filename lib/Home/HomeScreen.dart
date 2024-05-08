import 'package:flutter/material.dart';
import 'package:movie_api/Detail/detailScreen.dart';
import 'package:movie_api/Genre/genreProvider.dart';
import 'package:movie_api/Genre/genreScreen.dart';
import 'package:movie_api/movie_model.dart';
import 'package:movie_api/Home/homeProvider.dart';
import 'package:scroll_page_view/pager/page_controller.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, int> genreIds = {
    'All': 0,
    'Action': 28,
    'Romance': 10749,
    'Comedy': 35,
  };

  String selectedCategory = 'All';

  int _selectedButton = 0;
  late HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();
    _homeProvider = HomeProvider();
  }

  Widget _buildButton(int genreId, String text, Color buttonColor) {
    return Container(
      width: 110,
      child: ElevatedButton(
        onPressed: () async {
          if (genreId != 0) {
            final result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GenreScreen(
                genreId: genreId,
                genreName: text,
              ),
            ));
            if (result == true) {
              setState(() {
                _selectedButton = 0;
                selectedCategory = 'All';
              });
              _homeProvider.fetchPopularMovies();
              _homeProvider.fetchTopRatedMovies();
              _homeProvider.fetchNowPlayingMovies();
            }
          } else {
            _homeProvider.fetchPopularMovies();
            _homeProvider.fetchTopRatedMovies();
            _homeProvider.fetchNowPlayingMovies();
          }
        },
        child: Text(text, style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _selectedButton == genreId ? Colors.red : buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>.value(
        value: _homeProvider,
        child: Scaffold(
            body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                  child: SizedBox(
                height: 300,
                child: FutureBuilder(
                  future: _homeProvider.fetchUpcomingMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.error != null) {
                      return Center(
                          child: Text(
                        'An error occurred!',
                        style: TextStyle(color: Colors.white),
                      ));
                    } else {
                      return Consumer<HomeProvider>(
                        builder: (context, _homeProvider, child) {
                          return ScrollPageView(
                            controller: ScrollPageController(),
                            children: _homeProvider.upcomingMovies
                                .map((movie) => _imageView(movie))
                                .toList(),
                          );
                        },
                      );
                    }
                  },
                ),
              )),
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildButton(
                              genreIds['All']!, 'All', Color(0xFF31304D)),
                          SizedBox(width: 5),
                          _buildButton(
                              genreIds['Action']!, 'Action', Color(0xFF31304D)),
                          SizedBox(width: 5),
                          _buildButton(genreIds['Romance']!, 'Romance',
                              Color(0xFF31304D)),
                          SizedBox(width: 5),
                          _buildButton(
                              genreIds['Comedy']!, 'Comedy', Color(0xFF31304D)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (selectedCategory == 'All') ...[
                      Text(
                        'Most Popular',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      buildMovieList(
                          'Most Popular', _homeProvider.fetchPopularMovies),
                      Text(
                        'Top Rated',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      buildMovieList(
                          'Top Rated', _homeProvider.fetchTopRatedMovies),
                      Text(
                        'Now Playing',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      buildMovieList(
                          'Now Playing', _homeProvider.fetchNowPlayingMovies),
                    ],
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )),
            ],
          ),
        )));
  }

  Widget _imageView(Result movie) {
    String imageUrl = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';
    print('Image URL: $imageUrl'); // Print image URL
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildMovieList(
      String category, Future<void> Function() fetchFunction) {
    return FutureBuilder(
      future: fetchFunction(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return Center(
              child: Text(
            'An error occurred!',
            style: TextStyle(color: Colors.white),
          ));
        } else {
          return Consumer2<HomeProvider, GenreProvider>(
            builder: (ctx, homeData, genreData, _) {
              List<Result> movies;
              switch (category) {
                case 'Most Popular':
                  movies = homeData.popularMovies;
                  break;
                case 'Top Rated':
                  movies = homeData.topratedmovies;
                  break;
                case 'Now Playing':
                  movies = homeData.nowplayingmovies;
                  break;
                default:
                  movies = genreData.moviesByGenre;
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: movies.map((movie) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: InkWell(
                          onTap: () {
                            print('Movie id: ${movie.id}');
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(movieId: movie.id),
                              ),
                            );
                          },
                          child: Container(
                            width: 120,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        }
      },
    );
  }
}
