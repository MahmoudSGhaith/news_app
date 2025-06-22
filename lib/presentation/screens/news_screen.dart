import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:news/app_manger/cubit/cubit_states.dart';
import 'package:news/app_manger/cubit/home_cubit.dart';
import 'package:news/app_manger/mvvm/mvvm_provider.dart';
import 'package:news/core/colors_manger/colors_manger.dart';
import 'package:news/extension/extensions.dart';
import 'package:news/models/news_response/Articles.dart';
import 'package:news/presentation/model/category_model.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/app_localizations.dart';

class NewsScreen extends StatelessWidget {
  final CategoryModel? categoryModel;
  final Articles? articles;

  NewsScreen({super.key, required this.categoryModel, this.articles});

  int selectedIndex = 0;

  late MvvmProvider mvvmProvider;

  @override
  Widget build(BuildContext context) {
    mvvmProvider = MvvmProvider()
      ..getSources(categoryModel?.id.toString() ?? "");
    return BlocProvider(
      create: (context) =>
      HomeCubit()
        ..getSources(categoryModel?.id.toString() ?? ""),
      child: Column(
        children: [
          BlocConsumer<HomeCubit, CubitStates>(
            listener: (context, state) {
              final cubit = context.read<HomeCubit>();
              if (state is SourceSuccessState) {
                cubit.getNews(state.sourcesList.first.id ?? "");
              }
            },
            builder: (context, state) {
              final cubit = context.read<HomeCubit>();
              if (state is SourceSuccessState) {
                return Column(
                  children: [
                    // todo : to show sources in tab bar
                    DefaultTabController(
                      initialIndex: cubit.selectedIndex,
                      length: state.sourcesList.length,
                      child: TabBar(
                        onTap: (value) {
                          cubit.changeNewsBySelectNewSource(
                            value,
                            state.sourcesList[value].id,
                          );
                        },
                        labelColor: Theme
                            .of(context)
                            .hoverColor,
                        unselectedLabelColor: Theme
                            .of(context)
                            .dividerColor,
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        indicatorColor: Theme
                            .of(context)
                            .hoverColor,
                        labelPadding: EdgeInsets.symmetric(
                          horizontal: context.heightQuery * 0.01,
                        ),
                        dividerColor: ColorsManger.transparentColor,
                        tabs: state.sourcesList!.map((e) {
                          return Tab(text: e?.name ?? "");
                        }).toList(),
                      ),
                    ),
                  ],
                );
              } else if (state is SourceErrorState) {
                return Text("Error to load data");
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme
                        .of(context)
                        .hoverColor,
                  ),
                );
              }
            },
            buildWhen: (previous, current) {
              return current is SourceSuccessState ||
                  current is SourceErrorState ||
                  current is SourceLoadingState;
            },
            listenWhen: (previous, current) {
              return current is SourceSuccessState ||
                  current is SourceErrorState ||
                  current is SourceLoadingState;
            },
          ),
          SizedBox(height: context.heightQuery * 0.02),
          BlocBuilder<HomeCubit, CubitStates>(
            builder: (context, state) {
              if (state is NewsSuccessState) {
                return state.articlesList.isEmpty
                    ? Column(
                  children: [
                    Lottie.asset("assets/images/lottie.json"),
                    Text(
                      AppLocalizations.of(context)!.no_data_here,
                      style: Theme
                          .of(context)
                          .textTheme
                          .displayMedium,
                    ),
                  ],
                )
                    : Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(
                          context.heightQuery * 0.03,
                        ),
                        onTap: () {
                          //todo : appear modal bottom sheet
                          showArticleDetailsBottomSheet(
                            context,
                            state.articlesList[index],
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: context.heightQuery * 0.015,
                          ),
                          padding: EdgeInsets.all(
                            context.heightQuery * 0.007,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme
                                  .of(context)
                                  .hoverColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              context.heightQuery * 0.025,
                            ),
                          ),
                          child: Column(
                            children: [
                              //todo : articles image
                              ClipRRect(
                                borderRadius:
                                BorderRadiusGeometry.circular(
                                  context.heightQuery * 0.025,
                                ),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                  state
                                      .articlesList[index]
                                      .urlToImage ??
                                      "",
                                  placeholder: (context, url) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Theme
                                            .of(
                                          context,
                                        )
                                            .hoverColor,
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
                              SizedBox(
                                height: context.heightQuery * 0.01,
                              ),
                              //todo : articles text
                              Text(
                                state.articlesList[index].title ?? "",
                                style: Theme
                                    .of(
                                  context,
                                )
                                    .textTheme
                                    .displaySmall,
                              ),
                              SizedBox(
                                height: context.heightQuery * 0.01,
                              ),
                              //todo : author name and articles publish date
                              Row(
                                children: [
                                  //todo : author name
                                  Expanded(
                                    flex: 5,
                                          child: Text(
                                            "By : ${state.articlesList[index]
                                                .author ?? ""}",
                                            maxLines: 1,
                                            style: Theme
                                                .of(
                                              context,
                                            )
                                                .textTheme
                                                .labelMedium,
                                          ),
                                  ),
                                  Spacer(),
                                  //todo : articles published date
                                  Text(
                                    timeago.format(
                                      DateTime.parse(
                                        state
                                            .articlesList[index]
                                            .publishedAt ??
                                            "",
                                      ),
                                    ),
                                    style: Theme
                                        .of(
                                      context,
                                    )
                                        .textTheme
                                        .labelMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: context.heightQuery * 0.01);
                    },
                    itemCount: state.articlesList!.length,
                  ),
                );
              } else if (state is NewsErrorState) {
                return Text("Error to load Data");
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme
                        .of(context)
                        .hoverColor,
                  ),
                );
              }
            },
            buildWhen: (previous, current) {
              return current is NewsSuccessState ||
                  current is NewsErrorState ||
                  current is NewsLoadingState;
            },
          ),
        ],
      ),
    );
  }

  void showArticleDetailsBottomSheet(BuildContext context, Articles? articles) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          color: Theme
              .of(context)
              .hoverColor,
          padding: EdgeInsets.all(context.heightQuery * 0.02),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: articles?.urlToImage ?? "",
                  placeholder: (context, url) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme
                            .of(context)
                            .hoverColor,
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Icon(Icons.error, color: Colors.red, size: 30);
                  },
                ),
              ),
              SizedBox(height: context.heightQuery * 0.02,),
              Text(
                articles?.title ?? "",
                style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall,
              ),
              SizedBox(height: context.heightQuery * 0.02,),
              Container(
                width: double.infinity,
                height: context.heightQuery * 0.09,
                child: CupertinoButton(
                  color: Theme
                      .of(context)
                      .canvasColor,
                  child: Text(
                    AppLocalizations.of(context)!.view_full_article,
                    style: Theme
                        .of(context)
                        .textTheme
                        .displaySmall,
                  ),
                  onPressed: () {
                    log("By ${articles?.url ?? ""}");
                    _launchUrl(articles?.url ?? "");
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      //todo : if true
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    }
  }
}
