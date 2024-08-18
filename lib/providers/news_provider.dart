import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/models/news_by_source_id.dart';
import 'package:news/models/sources.dart';
import 'package:news/services/news_api_service.dart';

class NewsProvider extends ChangeNotifier {
  final NewsApiService _newsApiService = NewsApiService();

  String? _sourceId;
  String? _searchKeyword;
  List<String> _selectedCategories = ['General']; // Default category
  Future<NewsBySourceId>? _newsItems;
  Sources? _sources; // New field to store sources

  // Getters
  String? get sourceId => _sourceId;
  String? get searchKeyword => _searchKeyword;
  List<String> get selectedCategories => _selectedCategories; // Getter for categories
  Future<NewsBySourceId>? get newsItems => _newsItems;
  Sources? get sources => _sources; // New getter for sources

  NewsProvider() {
    fetchSources('general'); // Default category
  }

  // Fetch sources based on category
  Future<void> fetchSources(String category) async {
    _sources = await _newsApiService.fetchSources(category);
    if (_sources != null && _sources!.sources!.isNotEmpty) {
      // Set the initial sourceId for the first tab
      final initialSourceId = _sources!.sources![0].id;
      setSourceId(initialSourceId!);
    }
    notifyListeners();
  }

  // Set source ID and fetch news
  void setSourceId(String sourceId) {
    _sourceId = sourceId;
    fetchNews();
  }

  // Set search keyword and fetch news
  void setSearchKeyword(String? keyword) {
    _searchKeyword = keyword;
    fetchNews();
  }

  // Set selected categories
  void setCategories(List<String> categories) {
    _selectedCategories = categories;
    fetchNews(); // Update news based on the new categories
  }

  // Fetch news based on the selected source, keyword, and categories
  Future<void> fetchNews() async {
    if (_sourceId != null) {
      _newsItems = _newsApiService.fetchNewsBySourceId(
        _sourceId!,
        _searchKeyword,
      );
      notifyListeners();
    }
  }
}