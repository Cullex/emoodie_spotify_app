class Artist {
  final String name;
  final String? imageUrl;
  final String? genre;
  final String? id;

  Artist({
    required this.name,
    this.imageUrl,
    this.genre,
    this.id,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      name: json['name'] ?? 'Unknown Artist',
      imageUrl: json['images'] != null && json['images'].isNotEmpty
          ? json['images'][0]['url']
          : null,
      genre: json['genres'] != null && json['genres'].isNotEmpty
          ? json['genres'].join(', ')
          : null,
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'genre': genre,
      'id': id,
    };
  }
}
