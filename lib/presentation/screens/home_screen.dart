import 'package:flutter/material.dart';
import 'package:news/core/colors_manger/colors_manger.dart';
import 'package:news/extension/extensions.dart';
import 'package:news/presentation/model/category_model.dart';
import 'package:news/provider/theme_language_provider.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  late List<CategoryModel> categories = [];
  Function onButtonClicked;

  HomeScreen({super.key, required this.onButtonClicked});

  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<ConfigProvider>(context);
    categories = CategoryModel.getCategories(configProvider.isLight);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(context.heightQuery * 0.01),
          child: Text(
            greeting(context),
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: context.heightQuery * 0.01),
          child: Text(
            AppLocalizations.of(context)!.here_is_some_news_for_you,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        SizedBox(height: context.screenSize.height * 0.015),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: context.heightQuery * 0.01,
                ),
                width: double.infinity,
                height: context.heightQuery * 0.28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).hoverColor,
                ),
                child: Stack(
                  alignment: (index % 2 == 0)
                      ? Alignment.bottomRight
                      : Alignment.bottomLeft,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        height: double.infinity,
                        image: AssetImage(categories[index].imagePath),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(context.heightQuery * 0.01),
                      width: context.widthQuery * 0.45,
                      height: context.heightQuery * 0.07,
                      decoration: BoxDecoration(
                        color: ColorsManger.grey,
                        borderRadius: BorderRadius.circular(
                          context.heightQuery * 0.05,
                        ),
                      ),
                      child: (index % 2 == 0)
                          ? InkWell(
                        onTap: () {
                          onButtonClicked(categories[index]);
                        },
                              child: Row(
                                children: [
                                  //todo : view all
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: context.heightQuery * 0.008,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.view_all,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: context.widthQuery * 0.145,
                                    height: context.heightQuery * 0.08,
                                    decoration: BoxDecoration(
                                      color: ColorsManger.black,
                                      borderRadius: BorderRadius.circular(
                                        context.heightQuery * 0.07,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: ColorsManger.white,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : InkWell(
                        onTap: () {
                          onButtonClicked(categories[index]);
                        },
                            child: Row(
                                children: [
                                  //todo : view all
                                  Container(
                                    width: context.widthQuery * 0.145,
                                    height: context.heightQuery * 0.08,
                                    decoration: BoxDecoration(
                                      color: ColorsManger.black,
                                      borderRadius: BorderRadius.circular(
                                        context.heightQuery * 0.07,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: ColorsManger.white,
                                      size: 30,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: context.heightQuery * 0.008,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.view_all,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                  ),
                                ],
                              ),
                          ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: context.heightQuery * 0.01);
            },
            itemCount: categories.length,
          ),
        ),
      ],
    );
  }

  String greeting(BuildContext context) {
    int hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return AppLocalizations.of(context)!.good_morning;
    } else if (hour >= 12 && hour < 18) {
      return AppLocalizations.of(context)!.good_after_noon;
    } else {
      return AppLocalizations.of(context)!.good_night;
    }
  }
}
