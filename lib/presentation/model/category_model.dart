import 'package:news/core/assets_manger/assets_manger.dart';

class CategoryModel {
  String id;
  String imagePath;
  String title;

  CategoryModel({required this.id, required this.imagePath , required this.title});

  static List<CategoryModel> getCategories(bool isDark) {
    return [
      CategoryModel(
        id: "general",
        title: "General",
        imagePath: isDark
            ? AssetsManger.darkGeneral
            : AssetsManger.lightGeneral,
      ),
      CategoryModel(
        id: "business",
        title: "Business",
        imagePath: isDark
            ? AssetsManger.darkBusniess
            : AssetsManger.lightBusniess,
      ),
      CategoryModel(
        id: "sports",
        title: "Sports",
        imagePath: isDark ? AssetsManger.darkSport : AssetsManger.lightSport,
      ),
      CategoryModel(
        id: "health",
        title: "Health",
        imagePath: isDark ? AssetsManger.darkHealth : AssetsManger.lightHealth,
      ),
      CategoryModel(
        id: "entertainment",
        title: "Entertainment",
        imagePath: isDark
            ? AssetsManger.darkEntertainment
            : AssetsManger.lightEntertainment,
      ),
      CategoryModel(
        id: "technology",
        title: "Technology",
        imagePath: isDark
            ? AssetsManger.darkTechnology
            : AssetsManger.lightTechnology,
      ),
      CategoryModel(
        id: "science",
        title: "Science",
        imagePath: isDark
            ? AssetsManger.darkScience
            : AssetsManger.lightScience,
      ),
    ];
  }
}
