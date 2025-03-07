import 'package:get/get.dart';
import 'package:snookerclub/models/payments_model.dart';

class PaymentsController extends GetxController {
  int index = 0;
  RxList<PaymentsModel> loserpaymoney = <PaymentsModel>[].obs;

  void changetap(int indextap) {
    index = indextap;
    update();
  }
}
