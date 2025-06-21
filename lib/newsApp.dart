
import 'package:flutter/material.dart';
import 'package:news/core/app_routes/app_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news/provider/theme_language_provider.dart';
import 'package:provider/provider.dart';
import 'core/app_theme/app_theme.dart';
import 'l10n/app_localizations.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<ConfigProvider>(context);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.mainLayout,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: configProvider.currentTheme,
      locale: Locale(configProvider.currentLanguage),
    );
  }
}
