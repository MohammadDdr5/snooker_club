import 'package:get/get.dart';
import 'package:snookerclub/models/tables_model.dart';

class TablesController extends GetxController {
  int index = 0;
  RxList<TablesModel> table = <TablesModel>[].obs;
}
