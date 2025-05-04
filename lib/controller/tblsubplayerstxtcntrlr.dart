import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tblsubplayerstxtcntrlr extends GetxController {
  TextEditingController? playerone;
  TextEditingController? playertwo;

  @override
  void onInit() {
    playerone = TextEditingController();
    playertwo = TextEditingController();

    super.onInit();
  }
}
