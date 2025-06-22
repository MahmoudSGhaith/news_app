import 'package:news/api/api_manger.dart';
import 'package:news/app_manger/cubit/search/search_data_source.dart';
import 'package:news/models/news_response/News_response.dart';
import 'package:news/models/sources_response/Source_response.dart';

class SearchDataSourceImpl extends SearchDataSource {
  @override
  Future<NewsResponse> search(String query) async {
    return await ApiManger.search(query: query);
  }
}
