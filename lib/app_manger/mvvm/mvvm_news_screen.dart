import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news/app_manger/mvvm/mvvm_provider.dart';
import 'package:news/core/colors_manger/colors_manger.dart';
import 'package:news/extension/extensions.dart';
import 'package:news/presentation/model/category_model.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../l10n/app_localizations.dart';

class MvvmNewsScreen extends StatefulWidget {
  final CategoryModel? categoryModel;

  MvvmNewsScreen({super.key, required this.categoryModel});

  final MvvmProvider mvvmProvider = MvvmProvider();

  @override
  State<MvvmNewsScreen> createState() => _MvvmNewsScreenState();
}

class _MvvmNewsScreenState extends State<MvvmNewsScreen> {
  int selectedIndex = 0;
  late MvvmProvider mvvmProvider;

  @override
  void initState() {
    mvvmProvider = MvvmProvider()
      ..getSources(widget.categoryModel?.id.toString() ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => mvvmProvider,
      builder: (context, child) {
        return Consumer<MvvmProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                SizedBox(height: context.heightQuery * 0.01),
                DefaultTabController(
                  length: provider.sourcesList.length,
                  initialIndex: provider.selectedIndex,
                  child: TabBar(
                    onTap: provider.getNewsByNewSelectedTab,
                    unselectedLabelColor: ColorsManger.grey.withAlpha(150),
                    labelColor: Theme.of(context).hoverColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: context.heightQuery * 0.01,
                    ),
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: context.heightQuery * 0.01,
                    ),
                    indicatorColor: ColorsManger.transparentColor,
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    tabs: provider.sourcesList.map((e) {
                      return Tab(text: e.name ?? "");
                    }).toList(),
                  ),
                ),
                SizedBox(height: context.heightQuery * 0.02),
                if (mvvmProvider.isLoading)
                  CircularProgressIndicator(color: Theme.of(context).hoverColor)
                else if (mvvmProvider.articlesList.isEmpty)
                  Column(
                    children: [
                      Lottie.asset("assets/images/lottie.json"),
                      Text(
                        AppLocalizations.of(context)!.no_data_here,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: context.heightQuery * 0.01,
                          ),
                          padding: EdgeInsets.only(
                            bottom: context.widthQuery * 0.015,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              context.heightQuery * 0.02,
                            ),
                            border: Border.all(
                              color: Theme.of(context).hoverColor,
                            ),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(
                                  context.heightQuery * 0.02,
                                ),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      mvvmProvider
                                          .articlesList[index]
                                          .urlToImage ??
                                      "",
                                  placeholder: (context, url) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Theme.of(context).hoverColor,
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size: 30,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: context.heightQuery * 0.015),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: context.heightQuery * 0.01,
                                ),
                                child: Text(
                                  mvvmProvider.articlesList[index].title ?? "",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),
                              ),
                              SizedBox(height: context.heightQuery * 0.015),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: context.heightQuery * 0.01,
                                      ),
                                      child: Container(
                                        child: Text(
                                          maxLines: 1,
                                          "By : ${mvvmProvider.articlesList[index].author ?? ""}",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.labelMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    child: Text(
                                      mvvmProvider
                                                  .articlesList[index]
                                                  .publishedAt !=
                                              null
                                          ? timeago.format(
                                              DateTime.parse(
                                                mvvmProvider
                                                    .articlesList[index]
                                                    .publishedAt!,
                                              ),
                                            )
                                          : "Unknown time",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: context.heightQuery * 0.01);
                      },
                      itemCount: mvvmProvider.articlesList.length,
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
