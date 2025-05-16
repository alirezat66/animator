import '../data/page_model.dart';
import 'page_local_datasource.dart';

class PageRepository {
  final PageLocalDataSource localDataSource;

  PageRepository({required this.localDataSource});

  Future<List<PageModel>> getPage() async {
    // In a real application, you might handle different data sources (remote, cache)
    // and implement more sophisticated error handling here.
    try {
      return await localDataSource.getPageData('assets/page.json');
    } catch (e) {
      print('Error in PageRepository: $e');
      rethrow; // Rethrow the exception
    }
  }
}