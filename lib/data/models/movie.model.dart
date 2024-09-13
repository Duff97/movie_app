class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;

  MovieModel(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterPath});

  factory MovieModel.fromjson(Map<String, dynamic> json) {
    return MovieModel(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        posterPath: json['poster_ath']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath
    };
  }
}
