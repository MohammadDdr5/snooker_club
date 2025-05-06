import 'package:get/get.dart';
import 'package:snookerclub/models/article.dart';

class NewsController extends GetxController {
  RxList<Article> news = <Article>[].obs;

  var isDone = false.obs;
  var newspageisempty = false.obs;
  void changeisdone() {
    isDone.value = !isDone.value;
  }
}
