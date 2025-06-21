
import 'package:flutter/material.dart';
import 'package:news/provider/theme_language_provider.dart';
import 'package:provider/provider.dart';

import 'newsApp.dart';

void main(){
  runApp(ChangeNotifierProvider(
      create: (context) => ConfigProvider(),
      child: NewsApp()));
}