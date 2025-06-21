import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/api_manger.dart';
import 'package:news/app_manger/cubit/cubit_states.dart';

class HomeCubit extends Cubit<CubitStates> {
  HomeCubit() : super(InitialState());

  Future<void> getNews(String sourceId) async {
    //todo: loading
    try {
      emit(NewsLoadingState());
      var newsData = await ApiManger.getNews(sources: sourceId);
      emit(NewsSuccessState(articlesList: newsData.articles ?? []));
    } catch (e) {
      emit(NewsErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getSources(String category) async {
    emit(SourceLoadingState());
    try {
      var sourceData = await ApiManger.getSources(category: category);
      emit(SourceSuccessState(sourcesList: sourceData.sources ?? []));
    } catch (e) {
      emit(SourceErrorState(errorMessage: e.toString()));
    }
  }

  int selectedIndex = 0;

  void changeNewsBySelectNewSource(int value, sourceId) {
    selectedIndex = value;
    getNews(sourceId);
  }
}
