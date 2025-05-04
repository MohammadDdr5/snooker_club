// ignore_for_file: await_only_futures, avoid_unnecessary_containers, unused_catch_clause

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

import 'package:snookerclub/classes/myconsts.dart';

import 'package:snookerclub/controller/news_controller.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:snookerclub/controller/themeandlang_controller.dart';
import 'package:snookerclub/models/article.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class NewsPage extends StatelessWidget {
  List<Article> articles = [];

  InAppWebViewController? webViewController;

  NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [languageMenu()],
          title: MyCustomAppbartitle(pagename: 'news'.tr),
          backgroundColor: myAppbarColor,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.newspaper_outlined),
          ),
        ),
        body: Obx(() {
          return Tooltip(
            message: 'For Update News Page Roll Down',
            child: RefreshIndicator(
                child: Get.find<NewsController>().isDone.value
                    ? bodyreturn()
                    : shimmerinterface(),
                onRefresh: () async {
                  dataloading();
                }),
          );
        }));
  }
}

//
bodyreturn() {
  return Container(
      child: ListView.separated(
    separatorBuilder: (context, index) => const Divider(),
    itemBuilder: (contex, index) {
      return Container(
        padding: const EdgeInsets.all(1),
        child: ListTile(
          subtitle: Text(Get.find<NewsController>().news[index].date!),
          onTap: () {
            webviewwidget(Get.find<NewsController>().news[index].url!);
          },
          onLongPress: () async {
            showDialog(
              context: contex,
              builder: (contex) {
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      _launchURL(Uri.parse(
                          Get.find<NewsController>().news[index].url!));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: myAppbarColor,
                      ),
                      width: Get.width * 0.6,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('openinchrome'.tr),
                          const Icon(Icons.web)
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          title: Text(Get.find<NewsController>().news[index].title!),
          leading: SizedBox(
            child: CachedNetworkImage(
              imageUrl: Get.find<NewsController>().news[index].urlimage!,
              fit: BoxFit.fitHeight,
              placeholder: (context, url) => const CircularProgressIndicator(),
            ),
          ),
        ),
      );
    },
    itemCount: Get.find<NewsController>().news.length,
  ));
}

//dataloading
dataloading() async {
  bool connection = await _checknetconnection();

  if (connection) {
    getwebsitedata().then((_) {
      Get.rawSnackbar(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 30, left: 100, right: 100),
          snackPosition: SnackPosition.TOP,
          borderRadius: 20,
          backgroundColor: Get.find<ThemeandlangController>().isthemedark.value
              ? Colors.black
              : Colors.white,
          messageText: Center(child: Text('newslistupdate'.tr)));
    });
  } else {
    Get.rawSnackbar(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 30, left: 100, right: 100),
        snackPosition: SnackPosition.TOP,
        borderRadius: 20,
        backgroundColor: Get.find<ThemeandlangController>().isthemedark.value
            ? Colors.black
            : Colors.white,
        messageText: Text(
          'connectionlost'.tr,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.wifi_off_rounded),
        isDismissible: false);
  }
}

// get data titles and subtitle image from the newssite
Future getwebsitedata() async {
  try {
    if (Get.find<NewsController>().news.isEmpty) {
      final url = Uri.parse('https://metro.co.uk/tag/snooker/');
      final response = await http.get(url);

      dom.Document html = dom.Document.html(response.body);

      final titles = html
          .querySelectorAll(
              'div.latest > div> div > div > div > div.article-card__inner > h3 > a')
          .map((element) => element.innerHtml.trim())
          .toList();
      final newslink = html
          .querySelectorAll(
              'div.latest > div> div > div > div > div.article-card__inner > h3 > a')
          .map((belement) => belement.attributes['href'])
          .toList();

      final urlimage = html
          .querySelectorAll(
              'div.latest > div > div > div > div > div.article-card__image > a > img')
          .map((clement) => clement.attributes['src'])
          .toList();

      final date = html
          .querySelectorAll(
              'div.latest > div > div > div> div > div.article-card__inner > div > div > span.article-card__date')
          .map((delement) => delement.innerHtml)
          .toList();

      Get.find<NewsController>().news.clear();
      for (var i = 0; i < titles.length; i++) {
        Get.find<NewsController>().news.add(Article(
            title: titles[i],
            url: newslink[i],
            urlimage: urlimage[i],
            date: date[i]));
      }
      Get.find<NewsController>().changeisdone();
    }
  } catch (e) {
    e.printError();
  }
}

//get website dTA
//get news bodytesite from the site

shimmerinterface() {
  return ListView.separated(
      itemBuilder: (context, index) {
        int delay = (index * 300);
        return Container(
          margin:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
          width: Get.width * 0.8,
          height: Get.height * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FadeShimmer(
                    radius: 15,
                    width: Get.width * 0.3,
                    height: Get.height * 0.1,
                    fadeTheme:
                        Get.find<ThemeandlangController>().isthemedark.value
                            ? FadeTheme.dark
                            : FadeTheme.light,
                    millisecondsDelay: delay,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FadeShimmer(
                        radius: 15,
                        width: Get.width * 0.55,
                        height: Get.height * 0.055,
                        fadeTheme:
                            Get.find<ThemeandlangController>().isthemedark.value
                                ? FadeTheme.dark
                                : FadeTheme.light,
                        millisecondsDelay: delay,
                      ),
                      const SizedBox(height: 10, width: 10),
                      FadeShimmer(
                        radius: 10,
                        width: Get.width * 0.1,
                        height: Get.height * 0.01,
                        fadeTheme:
                            Get.find<ThemeandlangController>().isthemedark.value
                                ? FadeTheme.dark
                                : FadeTheme.light,
                        millisecondsDelay: delay,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: 6);
}

Future<bool> _checknetconnection() async {
  int timeout = 3;
  try {
    http.Response response = await http
        .get(Uri.parse('https://www.google.com'))
        .timeout(Duration(seconds: timeout));
    if (response.statusCode == 200) {
      return true;
    } else {
      return Future.value(false);
    }
  } on TimeoutException catch (e) {
    return Future.value(false);
  } on SocketException catch (e) {
    return Future.value(false);
  } on Error catch (e) {
    return Future.value(false);
  }
}

//news complete webview
webviewwidget(String url) async {
  // ignore: unused_local_variable
  InAppWebViewController? webViewController;
  Get.dialog(
    SizedBox(
        width: Get.width,
        height: Get.height,
        child: InAppWebView(
          initialUrlRequest: await URLRequest(url: WebUri(url)),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
        )),
  );
}

//url launcher
Future<void> _launchURL(url) async {
  //you can also just use "void" or nothing at all - they all seem to work in this case
  if (!await launchUrl(url)) {
    throw Exception('couldnotlaunch $url'.tr);
  }
}
