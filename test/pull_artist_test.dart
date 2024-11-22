import 'package:emoodie_app/services/spotify_service.dart';
import 'package:emoodie_app/services/urls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';


void main() {
  group('Pull Artist Test', () {
    final SpotifyService spotifyService = SpotifyService();

    test('Should retrieve artists for a valid query', () async {
      final token = await spotifyService.getAccessToken();
      expect(token, isNotNull);

      final dio = Dio();
      final response = await dio.get(
        Urls.searchData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
        queryParameters: {
          'q': 'Adele',
          'type': 'artist',
          'limit': 5,
        },
      );

      expect(response.statusCode, 200);
      expect(response.data['artists'], isNotNull);
      expect(response.data['artists']['items'], isNotEmpty);
    });
  });
}
