import 'dart:async';
import 'package:flutter/material.dart';
import '../services/spotify_service.dart';

class SearchProvider with ChangeNotifier {
  final SpotifyService _spotifyService = SpotifyService();
  String _searchTerm = '';
  bool _isAlbumsSelected = true;

  List<dynamic> _albums = [];
  List<dynamic> _artists = [];
  Timer? _debounce;

  List<dynamic> get albums => _albums;
  List<dynamic> get artists => _artists;
  bool get isAlbumsSelected => _isAlbumsSelected;

  void updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;

    // Cancel any ongoing debounce timer
    _debounce?.cancel();

    // Start a new debounce timer
    _debounce = Timer(const Duration(milliseconds: 300), () {
      fetchData(); // Fetch data after the debounce delay
    });

    notifyListeners();
  }

  void toggleTabSelection(bool isAlbumsSelected) {
    _isAlbumsSelected = isAlbumsSelected;
    fetchData();
    notifyListeners();
  }

  Future<void> fetchData() async {
    if (_searchTerm.isEmpty) {
      _albums = [];
      _artists = [];
      notifyListeners();
      return;
    }

    try {
      if (_isAlbumsSelected) {
        _albums = await _spotifyService.search(_searchTerm, 'album');
      } else {
        _artists = await _spotifyService.search(_searchTerm, 'artist');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
