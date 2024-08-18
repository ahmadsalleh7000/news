import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/models/news.dart';
import 'package:news/models/news_by_source_id.dart';
import 'package:news/models/sources.dart';
import '../utils/constants.dart';

class NewsApiService {
  final String apiKey = API_KEY;

  Future<News> fetchTopHeadlines() async {
    final url = Uri.https(
        NEWS_API_BASE_URL, NEWS_API_pATH, {'apiKey': apiKey, 'country': 'us'});
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return News.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            'Failed to load news articles${response.statusCode}${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load news articles: $e');
    }
  }

  Future<Sources> fetchSources(String category) async {
    final url = Uri.https(
        NEWS_API_BASE_URL, SOURCES_API_pATH, {'apiKey': apiKey, 'category': category});
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return Sources.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            'Failed to load news sources ${response.statusCode}${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load news sources: $e');
    }
  }

  Future<NewsBySourceId> fetchNewsBySourceId(String sourceId, String? searchKeyWord) async {
    final url = Uri.https(
        NEWS_API_BASE_URL, NEWS_BY_SOURCE_ID_API_PATH, {'apiKey': apiKey, 'sources': sourceId, 'q': searchKeyWord ??''});
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return NewsBySourceId.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            'Failed to load news articles${response.statusCode}${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load news articles: $e');
    }
  }

}