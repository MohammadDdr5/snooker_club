import 'package:get/get.dart';
import 'package:snookerclub/models/article.dart';
import 'package:snookerclub/models/news_body.dart';

class NewsController extends GetxController {
  RxList<Article> news = <Article>[].obs;
  RxList<NewsBody> newsbody = <NewsBody>[].obs;
  var isDone = false.obs;
  var newspageisempty = false.obs;
  void changeisdone() {
    isDone.value = !isDone.value;
  }
}
