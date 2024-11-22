import 'package:dio/dio.dart';
import 'package:emoodie_app/services/api_credentials.dart';
import 'package:emoodie_app/services/urls.dart';

class AuthController {


  Future<String?> getSpotifyToken() async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var data = {
      'grant_type': 'client_credentials',
      'client_id': ApiCredentials.clientId,
      'client_secret':ApiCredentials.clientSecret
    };

    var dio = Dio();

    try {
      var response = await dio.post(Urls.fetchToken,
        options: Options(headers: headers),
        data: data);

      if (response.statusCode == 200) {
        String token = response.data['access_token'];
        print('Token: $token');
        return token;
      } else {
        print('Error: ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      print('Request failed: $e');
      return null;
    }
  }
}