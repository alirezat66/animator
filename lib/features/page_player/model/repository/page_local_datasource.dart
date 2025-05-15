import 'dart:convert';
import 'package:flutter/services.dart';
import '../data/page_model.dart';

abstract class PageLocalDataSource {
  Future<PageModel> getPageData(String assetPath);
}

class PageLocalDataSourceImpl implements PageLocalDataSource {
  @override
  Future<PageModel> getPageData(String assetPath) async {
    try {
      final jsonString = await rootBundle.loadString(assetPath);
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return PageModel.fromJson(jsonMap);
    } catch (e) {
      // In a real application, you might want more specific error handling
      // and potentially throw a custom exception.
      print('Error loading or parsing page data: $e');
      rethrow; // Rethrow the exception to be caught by the repository
    }
  }
}