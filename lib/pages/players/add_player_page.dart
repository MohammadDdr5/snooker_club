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
          title: const Text('صفحه افزودن بازیکن ها')),
      body: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              height: 80,
              width: Get.width,
              child: TextField(
                controller: Get.find<AddPlayertextcontroller>().playername,
                maxLines: 50,
                decoration: InputDecoration(
                    hintText: 'نام بازیکن',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              height: 80,
              width: Get.width,
              child: TextField(
                controller: Get.find<AddPlayertextcontroller>().playernumber,
                keyboardType: TextInputType.number,
                maxLines: 50,
                maxLength: 13,
                decoration: InputDecoration(
                    hintText: ' شماره تلفن بازیکن',
                    counterText: '',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() => Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Group',
                        style: TextStyle(
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
                      backgroundColor: Colors.lightGreenAccent),
                  onPressed: () {
                    Get.find<PlayersController>().players.add(PlayersModel(
                        name: Get.find<AddPlayertextcontroller>()
                            .playername!
                            .text
                            .toString(),
                        mobilenumber: (Get.find<AddPlayertextcontroller>()
                            .playernumber!
                            .text),
                        group: Get.find<PlayersController>().selected.value));
                    Get.back();
                    Get.snackbar(
                        'افزودن بازیکن به لیست', 'بازیکن به لیست اضافه شد');

                    Get.find<AddPlayertextcontroller>().playername!.text = '';
                    Get.find<AddPlayertextcontroller>().playernumber!.text = '';
                  },
                  child: const Text(
                    'افزودن بازیکن',
                    style: TextStyle(
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
