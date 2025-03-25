import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/controller/players_controller.dart';

class PlayersPage extends StatelessWidget {
  const PlayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      width: Get.width,
      child: const TableListView(),
    );
  }
}

class TableListView extends StatelessWidget {
  const TableListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(child: Obx(() {
      return ListView.separated(
          itemBuilder: (context, index) {
            return Container(
                padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.card_membership)),
                    ),
                    Text(Get.find<PlayersController>().players[index].name!),
                    Text(Get.find<PlayersController>()
                        .players[index]
                        .mobilenumber!),
                    Text(Get.find<PlayersController>().players[index].group!),
                  ],
                ));
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: Get.find<PlayersController>().players.length);
    }));
  }
}
