import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableTextcontroller extends GetxController {
  TextEditingController? tablename;
  TextEditingController? tableprice;
  @override
  void onInit() {
    tablename = TextEditingController();
    tableprice = TextEditingController();
    super.onInit();
  }
}
