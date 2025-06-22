import 'package:flutter/material.dart';
import 'package:news/core/app_routes/app_routes.dart';
import 'package:news/core/app_styles/app_styles.dart';
import 'package:news/extension/extensions.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/presentation/drawer/drawer_ui.dart';
import 'package:news/presentation/model/category_model.dart';
import 'package:news/presentation/screens/home_screen.dart';
import 'package:news/presentation/screens/news_screen.dart';

class MainLayout extends StatefulWidget {
  MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  CategoryModel? selectedCategoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).hoverColor,
        title: Text(
          selectedCategoryModel?.title ?? AppLocalizations.of(context)!.home,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              //todo: navigate to searchScreen
              Navigator.pushNamed(context, AppRoutes.search);
            },
            icon: Icon(
              Icons.search,
              color: Theme.of(context).canvasColor,
              size: 30,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).canvasColor,
        child: DrawerUi(gotoHome: gotoHome),
      ),
      body: selectedCategoryModel == null
          ? HomeScreen(onButtonClicked: selectedCategoryChanged)
          : NewsScreen(categoryModel: selectedCategoryModel),

      // ? HomeScreen(onButtonClicked: selectedCategoryChanged)
      //todo : if you want to use mvvm
      // : MvvmNewsScreen(categoryModel: selectedCategoryModel,),
    );
  }

  selectedCategoryChanged(CategoryModel newSelectedCategory) {
    selectedCategoryModel = newSelectedCategory;
    setState(() {});
  }

  gotoHome() {
    Navigator.pop(context);
    selectedCategoryModel = null;
    setState(() {});
  }
}
