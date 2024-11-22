import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/search_provider.dart';

class AlbumGrid extends StatelessWidget {
  const AlbumGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    final albums = searchProvider.albums;

    if (albums.isEmpty) {
      return const Center(
        child: Text(
          'No albums found',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 2 / 3,
      ),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        final imageUrl = (album['images'] != null && album['images'].isNotEmpty)
            ? album['images'][0]['url']
            : 'https://via.placeholder.com/150';
        final artistName = (album['artists'] != null && album['artists'].isNotEmpty)
            ? album['artists'][0]['name']
            : 'Unknown Artist';
        final releaseYear = (album['release_date'] ?? 'Unknown Date').split('-')[0];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                album['name'] ?? 'Unknown Album',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                artistName,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                releaseYear,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
