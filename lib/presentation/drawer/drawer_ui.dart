import 'package:flutter/material.dart';
import 'package:news/core/assets_manger/assets_manger.dart';
import 'package:news/extension/extensions.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/presentation/drawer/drawer_drop_down_menu.dart';
import 'package:news/presentation/drawer/drawer_widget.dart';
import 'package:news/presentation/model/category_model.dart';
import 'package:news/provider/theme_language_provider.dart';
import 'package:provider/provider.dart';

class DrawerUi extends StatelessWidget {
  final Function() gotoHome;
  const DrawerUi({super.key , required this.gotoHome});

  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<ConfigProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: context.heightQuery * 0.3,
          color: Theme
              .of(context)
              .hoverColor,
          child: Text(
            textAlign: TextAlign.center,
            "NewsApp",
            style: Theme
                .of(context)
                .textTheme
                .titleMedium,
          ),
        ),
        Container(
          child: Column(
            children: [
              //todo : for goto home
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: context.heightQuery * 0.05,
                ),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(AssetsManger.homeIcon),
                      color: Theme
                          .of(context)
                          .hoverColor,
                    ),
                    SizedBox(width: context.widthQuery * 0.02),
                    TextButton(
                      onPressed: gotoHome,
                      child: Text(
                        AppLocalizations.of(context)!.go_to_home,
                        style: Theme
                            .of(context)
                            .textTheme
                            .displayMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Theme
                    .of(context)
                    .hoverColor,
                indent: 30,
                endIndent: 30,
                thickness: 2,
              ),
              //todo: for theming
              DrawerWidget(
                text: AppLocalizations.of(context)!.theme,
                imagePath: AssetsManger.themeIcon,
              ),
              DrawerDropDownMenu(
                dropDownTextView: configProvider.isLight
                    ? AppLocalizations.of(context)!.light
                    : AppLocalizations.of(context)!.dark,
                selectedComponent: configProvider.isLight
                    ? AppLocalizations.of(context)!.light
                    : AppLocalizations.of(context)!.dark,
                dropDownItems: [
                  AppLocalizations.of(context)!.dark,
                  AppLocalizations.of(context)!.light,
                ],
                onChange: (theme) {
                  theme == AppLocalizations.of(context)!.light ? configProvider
                      .changeAppTheme(ThemeMode.light) : configProvider
                      .changeAppTheme(ThemeMode.dark);
                },
              ),
              Divider(
                color: Theme
                    .of(context)
                    .hoverColor,
                indent: 30,
                endIndent: 30,
                thickness: 2,
              ),
              //todo: for Language
              DrawerWidget(
                text: AppLocalizations.of(context)!.language,
                imagePath: AssetsManger.languageIcon,
              ),
              DrawerDropDownMenu(
                dropDownTextView: configProvider.isEnglish
                    ? AppLocalizations.of(context)!.english
                    : AppLocalizations.of(context)!.arabic,
                selectedComponent: configProvider.isEnglish
                    ? AppLocalizations.of(context)!.english
                    : AppLocalizations.of(context)!.arabic,
                dropDownItems: [
                  AppLocalizations.of(context)!.english,
                  AppLocalizations.of(context)!.arabic,
                ],
                onChange: (theme) {
                  theme == AppLocalizations.of(context)!.english ?
                  configProvider.changeAppLanguage("en") :
                  configProvider.changeAppLanguage("ar");
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
