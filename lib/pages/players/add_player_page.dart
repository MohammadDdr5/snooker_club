import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/controller/add_playertextcontroller.dart';
import 'package:snookerclub/controller/players_controller.dart';
import 'package:snookerclub/models/players_model.dart';

class AddPlayerPage extends StatelessWidget {
  const AddPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    PlayersController controller = PlayersController();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text(Get.find<PlayersController>().isedittingplayer
              ? 'playereditpage'.tr
              : 'playeraddpage'.tr)),
      body: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: const BoxDecoration(),
              height: 80,
              width: Get.width,
              child: TextField(
                controller: Get.find<AddPlayertextcontroller>().playername,
                maxLines: 50,
                decoration: InputDecoration(
                    hintText: 'playername'.tr,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: const BoxDecoration(),
              height: 80,
              width: Get.width,
              child: TextField(
                controller: Get.find<AddPlayertextcontroller>().playernumber,
                keyboardType: TextInputType.number,
                maxLines: 50,
                maxLength: 13,
                decoration: InputDecoration(
                    hintText: 'playerphonenumber'.tr,
                    counterText: '',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() => Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'group'.tr,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                          // updated
                          onChanged: (newValue) {
                            controller.selected.value = newValue!;
                            Get.find<PlayersController>().selected =
                                newValue.obs;
                            //updated
                          },
                          value: controller.selected.value, //updated
                          items: [
                            for (var value in controller.tierList)
                              DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value, //updated
                                ),
                              ),
                          ]),
                    ],
                  ),
                ))),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
              width: Get.width,
              height: 70,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    if (Get.find<PlayersController>().isedittingplayer ==
                        false) {
                      Get.find<PlayersController>().players.add(PlayersModel(
                          name: Get.find<AddPlayertextcontroller>()
                              .playername!
                              .text
                              .toString(),
                          mobilenumber: (Get.find<AddPlayertextcontroller>()
                              .playernumber!
                              .text),
                          group: Get.find<PlayersController>().selected.value));

                      Get.snackbar(
                          'addplayer'.tr,
                          ' ${Get.find<AddPlayertextcontroller>().playername!.text} '
                                  'playeraddedtolist'
                              .tr,
                          barBlur: 60,
                          margin:
                              const EdgeInsets.only(top: 10, left: 5, right: 5),
                          duration: const Duration(seconds: 5),
                          borderColor: const Color.fromARGB(137, 121, 117, 117),
                          borderWidth: 1.5,
                          backgroundColor: Colors.white60);

                      Get.find<AddPlayertextcontroller>().playername!.text = '';
                      Get.find<AddPlayertextcontroller>().playernumber!.text =
                          '';
                    } else {
                      var currentplayer = Get.find<PlayersController>()
                          .players[Get.find<PlayersController>().index];
                      currentplayer.name =
                          Get.find<AddPlayertextcontroller>().playername!.text;
                      currentplayer.mobilenumber =
                          Get.find<AddPlayertextcontroller>()
                              .playernumber!
                              .text;
                      currentplayer.group =
                          Get.find<PlayersController>().selected.value;
                      Get.find<PlayersController>()
                              .players[Get.find<PlayersController>().index] =
                          currentplayer;
                      Get.back();
                      Get.snackbar(
                          ('editplayer'.tr),
                          '${Get.find<AddPlayertextcontroller>().playername!.text} '
                                  "playeredited"
                              .tr,
                          barBlur: 60,
                          margin:
                              const EdgeInsets.only(top: 10, left: 5, right: 5),
                          duration: const Duration(seconds: 5),
                          borderColor: const Color.fromARGB(137, 121, 117, 117),
                          borderWidth: 1.5,
                          backgroundColor: Colors.white60);

                      Get.find<AddPlayertextcontroller>().playername!.text = '';
                      Get.find<AddPlayertextcontroller>().playernumber!.text =
                          '';
                    }
                  },
                  child: Text(
                    Get.find<PlayersController>().isedittingplayer
                        ? 'editplayer'.tr
                        : 'addplayer'.tr,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
