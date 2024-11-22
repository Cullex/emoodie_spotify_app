class Album {
  final String name;
  final String artist;
  final String releaseYear;
  final List<String> images;

  Album({
    required this.name,
    required this.artist,
    required this.releaseYear,
    required this.images,
  });

  // Factory constructor to create an Album from JSON
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'] ?? 'Unknown Album',
      artist: (json['artists']?.isNotEmpty ?? false)
          ? json['artists'][0]['name']
          : 'Unknown Artist',
      releaseYear: json['release_date']?.substring(0, 4) ?? 'Unknown',
      images: json['images']?.map<String>((image) => image['url']).toList() ?? [],
    );
  }
}
