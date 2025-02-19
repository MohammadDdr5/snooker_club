import 'package:get/get.dart';
import 'package:snookerclub/controller/games_controller.dart';
import 'package:snookerclub/controller/home_controller.dart';
import 'package:snookerclub/controller/players_controller.dart';
import 'package:snookerclub/controller/tables_controller.dart';

class Mybindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TablesController());
    Get.lazyPut(() => GamesController());
    Get.lazyPut(() => PlayersController());
    Get.lazyPut(() => HomeController());
  }
}
