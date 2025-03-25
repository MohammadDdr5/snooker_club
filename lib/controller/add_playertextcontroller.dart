import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPlayertextcontroller extends GetxController {
  TextEditingController? playername;
  TextEditingController? playernumber;

  @override
  void onInit() {
    playername = TextEditingController();
    playernumber = TextEditingController();

    super.onInit();
  }
}
