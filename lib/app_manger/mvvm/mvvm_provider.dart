import 'package:flutter/widgets.dart';
import 'package:news/api/api_manger.dart';
import 'package:news/models/news_response/Articles.dart';
import 'package:news/models/sources_response/Sources.dart';

class MvvmProvider extends ChangeNotifier {
  List<Articles> articlesList = [];
  List<Sources> sourcesList = [];
  bool isLoading = false;
  int selectedIndex = 0;

  Future<void> getNews(String sourceId) async {
    isLoading = true;
    notifyListeners();
    try {
      var newsData = await ApiManger.getNews(sources: sourceId);
      articlesList = newsData.articles ?? articlesList;
    } catch (e) {
      throw e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getSources(String categoryId) async {
    isLoading = true;
    notifyListeners();
    try {
      var sourceResponse = await ApiManger.getSources(category: categoryId);
      sourcesList = sourceResponse.sources ?? sourcesList;
      if (sourcesList.isNotEmpty) {
        await getNews(sourcesList.first.id ?? "");
      }
    } catch (e) {
      print("Error loading sources: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  void getNewsByNewSelectedTab(int newSelectedTab) {
    selectedIndex = newSelectedTab;
    getNews(sourcesList[newSelectedTab].id.toString());
    notifyListeners();
  }
}
