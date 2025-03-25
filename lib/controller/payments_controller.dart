import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snookerclub/models/payments_model.dart';

class PaymentsController extends GetxController {
  int index = 0;
  RxList<PaymentsModel> loserpaymoney = <PaymentsModel>[].obs;

  void changetap(int indextap) {
    index = indextap;
    update();
  }

  @override
  void onInit() {
    var box = GetStorage();
    if (box.read('loserpaymoney') != null) {
      var list = box.read('loserpaymoney');
      for (var element in list) {
        loserpaymoney.add(PaymentsModel.fromjson(element));
      }
    }

    ever(loserpaymoney, (value) {
      box.write('loserpaymoney', loserpaymoney.toJson());
    });
    super.onInit();
  }
}
