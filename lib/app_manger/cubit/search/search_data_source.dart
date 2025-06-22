import 'package:news/models/news_response/News_response.dart';

abstract class SearchDataSource {
  Future<NewsResponse> search(String query);
}
