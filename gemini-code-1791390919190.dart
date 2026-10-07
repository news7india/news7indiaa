import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_post.dart';
import '../models/news_category.dart';

class WordPressService {
  static const String baseUrl = 'https://www.news7india.com/wp-json/wp/v2';

  static Future<List<NewsPost>> fetchPosts({
    int? categoryId,
    String? searchQuery,
    int page = 1,
    int perPage = 15,
  }) async {
    try {
      String url = '$baseUrl/posts?page=$page&per_page=$perPage&_embed=1';
      if (categoryId != null && categoryId > 0) {
        url += '&categories=$categoryId';
      }
      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        url += '&search=${Uri.encodeComponent(searchQuery.trim())}';
      }
      final response = await http.get(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 12));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => NewsPost.fromJson(json)).toList();
      } else {
        throw Exception('Server returned status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }

  static Future<List<NewsCategory>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categories?per_page=25&hide_empty=true'),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => NewsCategory.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}