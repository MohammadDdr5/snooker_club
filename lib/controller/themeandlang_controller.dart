import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

var box = GetStorage();

class ThemeandlangController extends GetxController {
  var isthemedark = box.read('theme') ?? false ? true.obs : false.obs;
  var islanuageenglish = false.obs;
  void themechanger() {
    isthemedark.value = !isthemedark.value;
  }

  void languagechange() {
    islanuageenglish.value = !islanuageenglish.value;
  }
}
