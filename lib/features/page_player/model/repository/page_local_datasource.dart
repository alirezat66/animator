import 'dart:convert';
import 'package:flutter/services.dart';
import '../data/page_model.dart';

abstract class PageLocalDataSource {
  Future<List<PageModel>> getPageData(String assetPath);
}

class PageLocalDataSourceImpl implements PageLocalDataSource {
  @override
  Future<List<PageModel>> getPageData(String assetPath) async {
    try {
      final jsonString = await rootBundle.loadString(assetPath);
      final jsonMap = json.decode(jsonString);
      final List<dynamic> pagesJson = jsonMap as List<dynamic>;
      final List<PageModel> pages =
          pagesJson
              .map((page) => PageModel.fromJson(page as Map<String, dynamic>))
              .toList();
      return pages;
    } catch (e) {
      // In a real application, you might want more specific error handling
      // and potentially throw a custom exception.
      print('Error loading or parsing page data: $e');
      rethrow; // Rethrow the exception to be caught by the repository
    }
  }
}
