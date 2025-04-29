import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslateController extends GetxController {
  void changelanguage(String language) {
    var local = Locale(language);
    Get.updateLocale(local);
  }
}
