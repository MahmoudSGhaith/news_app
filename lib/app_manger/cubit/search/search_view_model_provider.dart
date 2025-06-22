import 'package:flutter/material.dart';
import 'package:news/api/api_manger.dart';
import 'package:news/models/news_response/News_response.dart';
import 'search_data_source.dart';

class SearchViewModelProvider extends ChangeNotifier {
  final SearchDataSource searchDataSource;

  SearchViewModelProvider({required this.searchDataSource});

  bool isLoading = false;
  String? errorMessage;
  NewsResponse? searchResults;

  Future<void> search(String query) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      searchResults = await searchDataSource.search(query);
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
