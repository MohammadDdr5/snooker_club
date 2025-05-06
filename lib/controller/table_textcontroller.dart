import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableTextcontroller extends GetxController {
  TextEditingController? tablename;
  TextEditingController? tableprice;

  var nameValidate = false.obs;
  var priceValidate = false.obs;
  @override
  void onInit() {
    tablename = TextEditingController();
    tableprice = TextEditingController();
    super.onInit();
  }
}
