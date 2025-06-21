
import 'package:flutter/material.dart';

import '../../presentation/main_layout.dart';

class AppRoutes {
  static final String mainLayout = "/mainLayout";

  static Map<String , WidgetBuilder> routes = {
    mainLayout : (context) => MainLayout(),

  };
}