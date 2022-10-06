final String tabelnamewhislist = 'whislisttabel';

class WhislistFields {
  final List<String> values = [poster, name, popularity];
  final String id = '_id';
  static final String poster = 'img';
  static final String name = 'name';
  static final String popularity = 'popularity';
}

class WhislistModel {
  final int? id;
  final String poster;
  final String name;
  final String popularity;

  WhislistModel(
      {this.id,
      required this.poster,
      required this.name,
      required this.popularity});

  static WhislistModel fromJson(Map<String, Object?> json) => WhislistModel(
      popularity: json[WhislistFields.popularity] as String,
      name: json[WhislistFields.name] as String,
      poster: json[WhislistFields.poster] as String);

  Map<String, Object?> toJson() => {
        WhislistFields.popularity: popularity,
        WhislistFields.name: name,
        WhislistFields.poster: poster
      };
  WhislistModel copy(
          {int? id, String? title, String? author, String? imageUrl}) =>
      WhislistModel(
          id: id ?? this.id,
          popularity: title ?? this.popularity,
          name: author ?? this.name,
          poster: imageUrl ?? this.poster);
}
