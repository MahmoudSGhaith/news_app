import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news/extension/extensions.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import '../../../app_manger/cubit/search/search_data_source_impl.dart';
import '../../../app_manger/cubit/search/search_view_model_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/news_response/Articles.dart';

class SearchView extends StatefulWidget {
  SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchController = TextEditingController();
  late SearchViewModelProvider searchViewModelProvider;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          SearchViewModelProvider(searchDataSource: SearchDataSourceImpl()),
      builder: (context, child) {
        var searchProvider = Provider.of<SearchViewModelProvider>(
            context, listen: false);
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(height: context.heightQuery * 0.015),
                //todo : arrow back to go to home screen
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: context.heightQuery * 0.01,
                  ),
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).hoverColor,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(height: context.heightQuery * 0.015),
                //todo : text form field for searching
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: context.heightQuery * 0.02,
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      if (value
                          .trim()
                          .isEmpty) {
                        searchProvider.DeleteSearchArticles();
                      } else {
                        searchProvider.search(value);
                      }
                    },
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    controller: searchController,
                    style: (Theme.of(context).textTheme.displayMedium),
                    cursorColor: Theme.of(context).hoverColor,
                    decoration: InputDecoration(
                      //todo : icon search
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).hoverColor,
                        size: 30,
                      ),
                      //todo : delete icon
                      suffixIcon: IconButton(
                        onPressed: () {
                          searchController.clear();
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).hoverColor,
                          size: 30,
                        ),
                      ),
                      labelText: "Search",
                      labelStyle: Theme.of(context).textTheme.displaySmall!
                          .copyWith(
                            color: Theme.of(context).hoverColor.withAlpha(150),
                          ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          context.heightQuery * 0.02,
                        ),
                        borderSide: BorderSide(
                          color: Theme.of(context).hoverColor,
                          strokeAlign: 1.5,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          context.heightQuery * 0.02,
                        ),
                        borderSide: BorderSide(
                          color: Theme.of(context).hoverColor,
                          width: 2,
                          strokeAlign: 2,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          context.heightQuery * 0.02,
                        ),
                        borderSide: BorderSide(
                          color: Theme.of(context).hoverColor,
                          width: 2,
                          strokeAlign: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          context.heightQuery * 0.02,
                        ),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2,
                          strokeAlign: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: context.heightQuery * 0.015),
                Expanded(
                  child: Consumer<SearchViewModelProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading)
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).hoverColor,
                          ),
                        );
                      if (provider.errorMessage != null)
                        return Text(
                          searchProvider.errorMessage!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      final articles = provider.searchResults?.articles;
                      if (searchController.text
                          .trim()
                          .isEmpty || articles == null || articles.isEmpty) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Lottie.asset("assets/images/lottie.json"),
                              Text(
                                "please search to show articles",
                                style: Theme.of(
                                  context,
                                ).textTheme.displayMedium,
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(
                              context.heightQuery * 0.03,
                            ),
                            onTap: () {
                              //todo : appear modal bottom sheet
                              showArticleDetailsBottomSheet(
                                context,
                                articles[index],
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
                                  color: Theme.of(context).hoverColor,
                                ),
                                borderRadius: BorderRadius.circular(
                                  context.heightQuery * 0.025,
                                ),
                              ),
                              child: Column(
                                children: [
                                  //todo : articles image
                                  ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      context.heightQuery * 0.025,
                                    ),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          provider
                                              .searchResults!
                                              .articles![index]
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
                                  SizedBox(height: context.heightQuery * 0.01),
                                  //todo : articles text
                                  Text(
                                    provider
                                            .searchResults!
                                            .articles![index]
                                            .title ??
                                        "",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displaySmall,
                                  ),
                                  SizedBox(height: context.heightQuery * 0.01),
                                  //todo : author name and articles publish date
                                  Row(
                                    children: [
                                      //todo : author name
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          "By : ${provider.searchResults!.articles![index].author ?? ""}",
                                          maxLines: 1,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.labelMedium,
                                        ),
                                      ),
                                      Spacer(),
                                      //todo : articles published date
                                      Text(
                                        timeago.format(
                                          DateTime.parse(
                                            provider
                                                    .searchResults!
                                                    .articles?[index]
                                                    .publishedAt ??
                                                "",
                                          ),
                                        ),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelMedium,
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
                        itemCount: articles.length,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showArticleDetailsBottomSheet(BuildContext context, Articles? articles) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          color: Theme.of(context).hoverColor,
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
                        color: Theme.of(context).hoverColor,
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Icon(Icons.error, color: Colors.red, size: 30);
                  },
                ),
              ),
              SizedBox(height: context.heightQuery * 0.02),
              Text(
                articles?.title ?? "",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: context.heightQuery * 0.02),
              Container(
                width: double.infinity,
                height: context.heightQuery * 0.09,
                child: CupertinoButton(
                  color: Theme.of(context).canvasColor,
                  child: Text(
                    AppLocalizations.of(context)!.view_full_article,
                    style: Theme.of(context).textTheme.displaySmall,
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
