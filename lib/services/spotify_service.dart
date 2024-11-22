import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'api_credentials.dart';
import 'urls.dart';



class SpotifyService {
  final Dio _dio = Dio();
  String? _accessToken;
  DateTime? _tokenExpiry;

  Future<String?> authenticate() async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    var body = {
      'grant_type': 'client_credentials',
      'client_id': ApiCredentials.clientId,
      'client_secret': ApiCredentials.clientSecret,
    };

    try {
      var response = await _dio.post(Urls.fetchToken,
        options: Options(headers: headers),
        data: body,
      );

      if (response.statusCode == 200) {
        _accessToken = response.data['access_token'];
        final int expiresIn = response.data['expires_in']; // In seconds
        _tokenExpiry = DateTime.now().add(Duration(seconds: expiresIn));
        return _accessToken;
      } else {
        print('Error: ${response.statusMessage}');
        return null;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        Fluttertoast.showToast(msg: 'Connection Timeout: Please check your internet connection.');
        print('Connection Timeout: Please check your internet connection.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        Fluttertoast.showToast(msg: 'Server is taking too long to respond..');
        print('Receive Timeout: The server is taking too long to respond.');
      } else if (e.type == DioExceptionType.badCertificate) {
        Fluttertoast.showToast(msg: 'An error occurred. Try Later');
        print('SSL Error: Please check your server\'s SSL certificate.');
      } else {
        Fluttertoast.showToast(msg: 'An error occurred. Try Later');
        print('DioError: ${e.message}');
      }
      return null;
    } catch (e) {
      print('Request failed: $e');
      return null;
    }
  }

  Future<String?> getAccessToken() async {
    // If no token or token has expired, refresh it
    if (_accessToken == null || _tokenExpiry == null || DateTime.now().isAfter(_tokenExpiry!)) {
      return await authenticate();
    }
    return _accessToken;
  }

  Future<List<dynamic>> searchArtists(String query) async {
    return await search(query, 'artist');
  }

  Future<List<dynamic>> searchAlbums(String query) async {
    return await search(query, 'album');
  }

  Future<List<dynamic>> search(String query, String type) async {
    try {
      final token = await getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }

      final response = await _dio.get(Urls.searchData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
        queryParameters: {
          'q': query,
          'type': type,
          'limit': 20, // Limit the results
        },
      );

      print('QUERY: ${query.toString()}');
      print('Spotify API Response: ${response.data}');

      if (response.data != null) {
        if (type == 'album' && response.data['albums'] != null) {
          final albums = response.data['albums']['items'] ?? [];
          return albums.map((album) {
            return {
              'name': album['name'] ?? 'Unknown Album',
              'images': album['images'] ?? [],
              'artists': album['artists'] ?? [],
              'release_date': album['release_date'],
            };
          }).toList();
        } else if (type == 'artist' && response.data['artists'] != null) {
          return response.data['artists']['items'] ?? [];
        } else {
          print('Error: Unexpected response structure');
          return [];
        }
      } else {
        print('Error: No data found');
        return [];
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        print('Connection Timeout: Please check your internet connection.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        print('Receive Timeout: The server is taking too long to respond.');
      } else if (e.type == DioExceptionType.badCertificate) {
        print('SSL Error: Please check your server\'s SSL certificate.');
      } else {
        print('DioError: ${e.message}');
      }
      return [];
    } catch (e) {
      print('Error during search: $e');
      return [];
    }
  }
}
