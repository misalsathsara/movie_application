class Movie {
  final String title;
  final String backDropPath;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final List<String> genres;
  final double rating;
  final String? trailerKey;
  bool isFavorite;

  Movie({
    required this.title,
    required this.backDropPath,
    required this.posterPath,
    required this.overview,
    this.releaseDate = '',
    this.genres = const [],
    this.rating = 0.0,
    this.trailerKey,
    this.isFavorite = false,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? '',
      backDropPath: map['backdrop_path'] ?? '',
      posterPath: map['poster_path'] ?? '',
      overview: map['overview'] ?? '',
      releaseDate: map['release_date'] ?? '',
      rating: (map['vote_average'] ?? 0.0) * 1.0,
      genres: List<String>.from(map['genre_ids']?.map((id) => id.toString()) ?? []),
    );
  }

  Movie copyWith({bool? isFavorite}) {
    return Movie(
      title: title,
      backDropPath: backDropPath,
      posterPath: posterPath,
      overview: overview,
      releaseDate: releaseDate,
      genres: genres,
      rating: rating,
      trailerKey: trailerKey,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}