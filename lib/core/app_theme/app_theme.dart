import 'package:flutter/material.dart';
import 'package:news/core/app_styles/app_styles.dart';
import 'package:news/core/colors_manger/colors_manger.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManger.white,
    hoverColor: ColorsManger.black,
    canvasColor: ColorsManger.white,
    dividerColor: ColorsManger.grey,
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorsManger.black,
        iconTheme: IconThemeData(color: ColorsManger.white , size: 30)
    ),
    textTheme: TextTheme(
        displaySmall: AppStyles.black16bold,
        displayMedium: AppStyles.black22medium,
        displayLarge: AppStyles.black24medium,
        labelSmall: AppStyles.black14medium,
        labelMedium: AppStyles.grey15medium,
        titleMedium: AppStyles.white22medium,
        titleSmall: AppStyles.white16bold
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManger.black,
    hoverColor: ColorsManger.white,
    dividerColor: ColorsManger.grey,
    canvasColor: ColorsManger.black,
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorsManger.white,
        iconTheme: IconThemeData(color: ColorsManger.black , size: 30)
    ),
    textTheme: TextTheme(
        displaySmall: AppStyles.white16bold,
        displayMedium: AppStyles.white22medium,
        displayLarge: AppStyles.white24medium,
        labelSmall: AppStyles.white14medium,
        labelMedium: AppStyles.grey15medium,
        titleMedium: AppStyles.black22medium,
        titleSmall: AppStyles.black16bold
    ),
  );
}
