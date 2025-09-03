import 'package:flutter/material.dart';
import '../providers/genre_provider.dart';
import '../../features/movies/data/models/legacy_movie_model.dart';
import 'package:provider/provider.dart';

class GenreScreen extends StatefulWidget {
  final int genreId;
  final String genreName;

  const GenreScreen({required this.genreId, required this.genreName, super.key});

  @override
  _GenreScreenState createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  late Future<void> _fetchMoviesFuture;

  @override
  void initState() {
    super.initState();
    _fetchMoviesFuture = Provider.of<GenreProvider>(context, listen: false)
        .fetchMoviesByGenre(widget.genreId);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, true);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.genreName,
              style: const TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xFF03002e),
            iconTheme: const IconThemeData(
              color: Colors.white, 
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 7),
            child: FutureBuilder(
              future: _fetchMoviesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.error != null) {
                  return const Center(child: Text('An error occurred!'));
                } else {
                  return Consumer<GenreProvider>(
                    builder: (context, genreProvider, child) {
                      return GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 2 / 3,
                        children: genreProvider.moviesByGenre.map((movie) {
                          return _buildMovieCard(_convertToResult(movie));
                        }).toList(),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ));
  }

  Result _convertToResult(movie) {
    return Result(
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
    );
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
}

  Widget _buildMovieCard(Result movie) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: () {},
          child: Container(
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
  }
