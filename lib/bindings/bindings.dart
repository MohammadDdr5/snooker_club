import 'package:get/get.dart';
import 'package:snookerclub/controller/add_playertextcontroller.dart';
import 'package:snookerclub/controller/home_controller.dart';
import 'package:snookerclub/controller/news_controller.dart';
import 'package:snookerclub/controller/payments_controller.dart';
import 'package:snookerclub/controller/players_controller.dart';

import 'package:snookerclub/controller/table_textcontroller.dart';
import 'package:snookerclub/controller/tables_controller.dart';
import 'package:snookerclub/controller/tblsubplayerstxtcntrlr.dart';
import 'package:snookerclub/controller/themeandlang_controller.dart';
import 'package:snookerclub/controller/translate_controller.dart';

class Mybindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TablesController());
    //when project finished return them too lazyput
    Get.put(TableTextcontroller());
    Get.lazyPut(() => NewsController());
    Get.put(PlayersController());
    Get.lazyPut(() => HomeController());
    Get.put(PaymentsController());
    Get.put(AddPlayertextcontroller());
    Get.put(Tblsubplayerstxtcntrlr());
    Get.put(TranslateController());
    Get.put(ThemeandlangController());
  }
}
