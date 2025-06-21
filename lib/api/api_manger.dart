import 'dart:convert';

import 'package:news/api/api_constant.dart';
import 'package:news/api/api_end_points.dart';
import 'package:news/models/news_response/News_response.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/sources_response/Source_response.dart';
import 'package:news/models/sources_response/Sources.dart';

class ApiManger {
  static Future<NewsResponse> getNews({String? query, String? sources}) async {
    try {
      var url = Uri.https(ApiConstant.baseUrl, ApiEndPoints.apiEveryThing, {
        if (query != null) "q": query,
        if (sources != null) "sources": sources,
        "apiKey": ApiConstant.apiKey,
      });
      var newsResponse = await http.get(url);
      print(newsResponse.body);
      if (newsResponse.statusCode == 200) {
        return NewsResponse.fromJson(jsonDecode(newsResponse.body));
      } else {
        throw Exception("error to load news ${newsResponse.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<SourceResponse> getSources({String? category}) async {
    try {
      var url = Uri.https(ApiConstant.baseUrl, ApiEndPoints.apiSources, {
        "category": category,
        "apiKey": ApiConstant.apiKey,
      });
      var sourceResponse = await http.get(url);
      if (sourceResponse.statusCode == 200) {
        return SourceResponse.fromJson(jsonDecode(sourceResponse.body));
      } else {
        throw Exception("error to load sources ${sourceResponse.body}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
