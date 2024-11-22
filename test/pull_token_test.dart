import 'package:emoodie_app/services/api_credentials.dart';
import 'package:emoodie_app/services/urls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';


void main() {
  group('Pull Token Test', () {
    final Dio dio = Dio();

    test('Should retrieve a valid token', () async {
      final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      final body = {
        'grant_type': 'client_credentials',
        'client_id': ApiCredentials.clientId,
        'client_secret': ApiCredentials.clientSecret,
      };

      final response = await dio.post(
        Urls.fetchToken,
        options: Options(headers: headers),
        data: body,
      );

      expect(response.statusCode, 200);
      expect(response.data['access_token'], isNotNull);
      expect(response.data['expires_in'], isNotNull);
    });
  });
}
