import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tblsubplayerstxtcntrlr extends GetxController {
  TextEditingController? playerone;
  TextEditingController? playertwo;
  var validateplayers = false.obs;

  @override
  void onInit() {
    playerone = TextEditingController();
    playertwo = TextEditingController();

    super.onInit();
  }
}
