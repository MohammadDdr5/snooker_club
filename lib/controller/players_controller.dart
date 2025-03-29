import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snookerclub/models/players_model.dart';

class PlayersController extends GetxController {
  int index = 0;
  final tierList = ['A', 'B', 'C', 'Others'].obs;
  var selected = "A".obs;
  bool isedittingplayer = false;

  RxList<PlayersModel> players = <PlayersModel>[].obs;
  void changetap(int indextap) {
    index = indextap;
    update();
  }

  @override
  void onInit() {
    var box = GetStorage();
    if (box.read('players') != null) {
      var list = box.read('players');
      for (var element in list) {
        players.add(PlayersModel.fromJson(element));
      }
    }
    ever(players, (value) {
      box.write('players', players.toJson());
    });

    super.onInit();
  }
}
