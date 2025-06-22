
import 'package:flutter/material.dart';
import 'package:news/presentation/screens/search/search_view.dart';

import '../../presentation/main_layout.dart';

class AppRoutes {
  static final String mainLayout = "/mainLayout";
  static final String search = "/search";

  static Map<String , WidgetBuilder> routes = {
    mainLayout : (context) => MainLayout(),
    search: (context) => SearchView(),
  };
}