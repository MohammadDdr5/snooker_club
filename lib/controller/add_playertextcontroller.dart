import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPlayertextcontroller extends GetxController {
  TextEditingController? playername;
  TextEditingController? playernumber;
  var isplayernameempty = false.obs;
  @override
  void onInit() {
    playername = TextEditingController();
    playernumber = TextEditingController();

    super.onInit();
  }
}
