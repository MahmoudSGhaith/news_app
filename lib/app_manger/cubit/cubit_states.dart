import 'package:news/models/news_response/Articles.dart';
import 'package:news/models/sources_response/Sources.dart';

sealed class CubitStates {}

class InitialState extends CubitStates {}

class NewsSuccessState extends CubitStates {
  final List<Articles> articlesList;

  NewsSuccessState({required this.articlesList});
}

class NewsErrorState extends CubitStates {
  String errorMessage;

  NewsErrorState({required this.errorMessage});
}

class NewsLoadingState extends CubitStates {}

class SourceSuccessState extends CubitStates {
  List<Sources> sourcesList;

  SourceSuccessState({required this.sourcesList});
}

class SourceErrorState extends CubitStates {
  String errorMessage;

  SourceErrorState({required this.errorMessage});
}

class SourceLoadingState extends CubitStates {}
