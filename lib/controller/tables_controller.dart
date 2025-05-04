import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snookerclub/models/tables_model.dart';

class TablesController extends GetxController {
  int index = 0;
  RxList<TablesModel> table = <TablesModel>[].obs;
  var startbuttonenable = true.obs;
  var stopbuttonenable = false.obs;
  var closeopenbutton = false.obs;
  var wholost = ''.obs;
  var iseditingtable = false.obs;
  @override
  void onInit() {
    var box = GetStorage();
    if (box.read('table') != null) {
      var list = box.read('table');
      for (var element in list) {
        table.add(TablesModel.fromJson(element));
      }
    }

    ever(table, (value) {
      box.write('table', table.toJson());
    });
    super.onInit();
  }
}
