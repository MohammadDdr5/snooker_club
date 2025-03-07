import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snookerclub/models/tables_model.dart';

class TablesController extends GetxController {
  int index = 0;
  RxList<TablesModel> table = <TablesModel>[].obs;

  @override
  void onInit() {
    var box = GetStorage();
    if (box.read('tables') != null) {
      var list = box.read('tables');
      for (var element in list) {
        table.add(TablesModel.fromjson(element));
      }
    }

    ever(table, (Value) {
      box.write('table', table.toJson());
    });
    super.onInit();
  }
}
