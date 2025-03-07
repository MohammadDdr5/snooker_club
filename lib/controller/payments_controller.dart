import 'package:get/get.dart';

class PaymentsController extends GetxController {
  int index = 0;
  void changetap(int indextap) {
    index = indextap;
    update();
  }
}
