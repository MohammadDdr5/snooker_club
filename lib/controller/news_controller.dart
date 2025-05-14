import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/controller/home_controller.dart';
import 'package:snookerclub/models/article.dart';
import 'package:snookerclub/pages/news/news_page.dart';

class NewsController extends GetxController {
  RxList<Article> news = <Article>[].obs;

  var isDone = false.obs;
  var newspageisempty = false.obs;
  void changeisdone() {
    isDone.value = !isDone.value;
    update();
  }

  @override
  void onInit() {
    if (news.isEmpty) {
      firstloading();
    }
    super.onInit();
  }

  firstloading() {
    if (Get.find<HomeController>().index == 3) {
      dataloading();
      return bodyreturn();
    } else {
      return Container();
    }
  }
}
