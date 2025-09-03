import '../../domain/entities/movie_detail.dart';

class MovieDetailModel extends MovieDetail {
  const MovieDetailModel({
    required super.id,
    required super.title,
    required super.overview,
    super.posterPath,
    super.backdropPath,
    required super.voteAverage,
    required super.voteCount,
    required super.releaseDate,
    required super.runtime,
    required super.genres,
    super.tagline,
    required super.budget,
    required super.revenue,
    required super.status,
    required super.adult,
    required super.originalLanguage,
    required super.originalTitle,
    required super.popularity,
    required super.video,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime'] ?? 0,
      genres: (json['genres'] as List?)
          ?.map((genre) => GenreModel.fromJson(genre))
          .toList() ?? [],
      tagline: json['tagline'],
      budget: json['budget'] ?? 0,
      revenue: json['revenue'] ?? 0,
      status: json['status'] ?? '',
      adult: json['adult'] ?? false,
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      popularity: (json['popularity'] ?? 0.0).toDouble(),
      video: json['video'] ?? false,
    );
  }
}

class GenreModel extends Genre {
  const GenreModel({
    required super.id,
    required super.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
