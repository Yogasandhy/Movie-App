class MovieDetail {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final int runtime;
  final List<Genre> genres;
  final String? tagline;
  final int budget;
  final int revenue;
  final String status;
  final bool adult;
  final String originalLanguage;
  final String originalTitle;
  final double popularity;
  final bool video;

  const MovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.runtime,
    required this.genres,
    this.tagline,
    required this.budget,
    required this.revenue,
    required this.status,
    required this.adult,
    required this.originalLanguage,
    required this.originalTitle,
    required this.popularity,
    required this.video,
  });
}

class Genre {
  final int id;
  final String name;

  const Genre({
    required this.id,
    required this.name,
  });
}
