import 'package:emoodie_app/services/urls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/search_provider.dart';

class ArtistList extends StatelessWidget {
  const ArtistList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    final artists = searchProvider.artists;

    if (artists.isEmpty) {
      return const Center(
        child: Text(
          'No artists found',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: artists.length,
      itemBuilder: (context, index) {
        final artist = artists[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              artist['images'].isNotEmpty
                  ? artist['images'][0]['url']
                  : Urls.placeHolderUrl
            ),
          ),
          title: Text(artist['name']!,
              style:
                  const TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
        );
      },
    );
  }
}
