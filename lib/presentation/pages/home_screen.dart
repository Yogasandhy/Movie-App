import 'package:flutter/material.dart';
import '../../features/movies/data/models/legacy_movie_model.dart';
import '../providers/home_provider.dart';
import '../providers/genre_provider.dart';
import 'detail_screen.dart';
import 'genre_screen.dart';
import 'search_screen.dart';
import 'see_all_movies_screen.dart';
import 'package:scroll_page_view/pager/page_controller.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Map<String, int> genreIds = {
    'All': 0,
    'Action': 28,
    'Romance': 10749,
    'Comedy': 35,
    'Horror': 27,
    'Drama': 18,
  };

  String selectedCategory = 'All';
  int _selectedButton = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadInitialData() async {
    final homeProvider = context.read<HomeProvider>();
    await homeProvider.fetchPopularMovies();
    await homeProvider.fetchTopRatedMovies();
    await homeProvider.fetchNowPlayingMovies();
    await homeProvider.fetchUpcomingMovies();
  }

  List<Result> _convertToResultList(List movies) {
    return movies.map((movie) => Result(
      adult: movie.adult,
      backdropPath: movie.backdropPath,
      genreIds: movie.genreIds,
      id: movie.id,
      originalLanguage: _getOriginalLanguage(movie.originalLanguage),
      originalTitle: movie.originalTitle,
      overview: movie.overview,
      popularity: movie.popularity,
      posterPath: movie.posterPath,
      releaseDate: movie.releaseDate,
      title: movie.title,
      video: movie.video,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
    )).toList();
  }

  OriginalLanguage _getOriginalLanguage(String language) {
    switch (language.toLowerCase()) {
      case 'en':
        return OriginalLanguage.EN;
      case 'fr':
        return OriginalLanguage.FR;
      case 'hi':
        return OriginalLanguage.HI;
      case 'ko':
        return OriginalLanguage.KO;
      default:
        return OriginalLanguage.EN;
    }
  }

  Widget _buildModernButton(int genreId, String text, int buttonId) {
    bool isSelected = _selectedButton == buttonId;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () async {
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
              final homeProvider = context.read<HomeProvider>();
              homeProvider.fetchPopularMovies();
              homeProvider.fetchTopRatedMovies();
              homeProvider.fetchNowPlayingMovies();
            }
          } else {
            setState(() {
              _selectedButton = buttonId;
              selectedCategory = 'All';
            });
            final homeProvider = context.read<HomeProvider>();
            homeProvider.fetchPopularMovies();
            homeProvider.fetchTopRatedMovies();
            homeProvider.fetchNowPlayingMovies();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    colors: [Colors.red, Color(0xFFFF6B6B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isSelected ? null : const Color(0xFF31304D),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.red.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[300],
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              // Header with greeting and search
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back! 👋',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Let\'s find movies',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Modern Search Bar
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SearchScreen()),
                        );
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF31304D),
                              const Color(0xFF31304D).withValues(alpha: 0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                Icons.search_rounded,
                                color: Colors.grey,
                                size: 24,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Search movies, genres...',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // Featured Movies Carousel
                    SliverToBoxAdapter(
                      child: Container(
                        height: 280,
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Consumer<HomeProvider>(
                          builder: (context, homeProvider, child) {
                            if (homeProvider.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(color: Colors.red),
                              );
                            } else if (homeProvider.errorMessage.isNotEmpty) {
                              return const Center(
                                child: Text(
                                  'Failed to load featured movies',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            } else if (homeProvider.upcomingMovies.isEmpty) {
                              return const Center(
                                child: CircularProgressIndicator(color: Colors.red),
                              );
                            } else {
                              return ScrollPageView(
                                controller: ScrollPageController(),
                                children: homeProvider.upcomingMovies
                                    .take(5)
                                    .map((movie) => _buildFeaturedMovieCard(movie))
                                    .toList(),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    // Categories
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Categories',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 15),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: genreIds.entries
                                    .map((entry) => _buildModernButton(
                                          entry.value,
                                          entry.key,
                                          entry.value,
                                        ))
                                    .toList(),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                    // Movie Sections
                    if (selectedCategory == 'All') ...[
                      _buildModernMovieSection('🔥 Trending Now', 'Popular'),
                      _buildModernMovieSection('⭐ Top Rated', 'Top Rated'),
                      _buildModernMovieSection('🎬 Now Playing', 'Now Playing'),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedMovieCard(movie) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailScreen(movieId: movie.id),
      )),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[800],
                    child: const Icon(
                      Icons.movie,
                      size: 80,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                movie.voteAverage.toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Colors.amber,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          movie.releaseDate.year.toString(),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernMovieSection(String title, String category) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final homeProvider = context.read<HomeProvider>();
                    List<Result> movies = [];
                    switch (category) {
                      case 'Popular':
                        movies = _convertToResultList(homeProvider.popularMovies);
                        break;
                      case 'Top Rated':
                        movies = _convertToResultList(homeProvider.topRatedMovies);
                        break;
                      case 'Now Playing':
                        movies = _convertToResultList(homeProvider.nowPlayingMovies);
                        break;
                    }
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeeAllMoviesScreen(
                          category: category,
                          title: title,
                          movies: movies,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'See all',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 270,
            child: _buildModernMovieList(category),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildModernMovieList(String category) {
    return Consumer2<HomeProvider, GenreProvider>(
      builder: (context, homeData, genreData, child) {
        List movies = [];

        switch (category) {
          case 'Popular':
            movies = homeData.popularMovies;
            break;
          case 'Top Rated':
            movies = homeData.topRatedMovies;
            break;
          case 'Now Playing':
            movies = homeData.nowPlayingMovies;
            break;
          default:
            movies = genreData.moviesByGenre;
        }

        if (movies.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.red),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailScreen(movieId: movie.id),
              )),
              child: Container(
                width: 160,
                margin: const EdgeInsets.only(right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Movie Poster - Fixed Height
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child: const Icon(
                                Icons.movie,
                                size: 50,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Movie Title - Fixed Height
                    SizedBox(
                      height: 40,
                      child: Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Rating and Year
                    SizedBox(
                      height: 20,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.voteAverage.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            movie.releaseDate.year.toString(),
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
