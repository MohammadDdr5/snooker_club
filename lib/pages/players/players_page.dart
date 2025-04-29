import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:snookerclub/classes/myconsts.dart';

import 'package:snookerclub/controller/add_playertextcontroller.dart';
import 'package:snookerclub/controller/players_controller.dart';
import 'package:snookerclub/controller/themeandlang_controller.dart';

class PlayersPage extends StatelessWidget {
  const PlayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyCustomAppbartitle(pagename: 'players'.tr),
        backgroundColor: myAppbarColor,
      ),
      body: SizedBox(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: Get.width * 0.18,
                      child: Text(
                        'playername'.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.24,
                      child: Text('playerphonenumber'.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    SizedBox(
                      width: Get.width * 0.10,
                      child: Text('group'.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                height: Get.height * 0.71,
                padding: const EdgeInsets.only(),
                width: Get.width,
                child: const TableListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TableListView extends StatelessWidget {
  const TableListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(child: Obx(() {
        return ListView.separated(
            itemBuilder: (context, index) {
              return Obx(() {
                return Container(
                  height: Get.height * 0.09,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color:
                            Get.find<ThemeandlangController>().isthemedark.value
                                ? const Color.fromARGB(255, 36, 35, 35)
                                : const Color.fromARGB(255, 236, 232, 232),
                        spreadRadius: 2,
                        blurRadius: 3)
                  ]),
                  child: Slidable(
                    // Specify a key if the Slidable is dismissible.
                    key: const ValueKey(0),

                    // The start action pane is the one at the left or the top side.
                    startActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),

                      // A pane can dismiss the Slidable.
                      dismissible: DismissiblePane(onDismissed: () {
                        playerDelete(index);
                      }),

                      // All actions are defined in the children parameter.
                      children: [
                        // A SlidableAction can have an icon and/or a label.

                        SlidableAction(
                          borderRadius: BorderRadius.circular(15),
                          onPressed: (_) => {playerDelete(index)},
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'delete'.tr,
                        ),
                      ],
                    ),

                    // The end action pane is the one at the right or the bottom side.
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          autoClose:
                              true, // An action can be bigger than the others.

                          onPressed: (_) {
                            playerEdit(index);
                          },
                          backgroundColor:
                              const Color.fromRGBO(255, 235, 59, 1),
                          foregroundColor: Colors.black,
                          icon: Icons.edit,
                          label: 'edit'.tr,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ],
                    ),

                    // The child of the Slidable is what the user sees when the
                    // component is not dragged.
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 15, left: 10, right: 10, bottom: 10),
                      width: Get.width,
                      height: 80,
                      child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircleAvatar(
                                    child: IconButton(
                                        onPressed: () {},
                                        icon:
                                            const Icon(Icons.person_outlined)),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.18,
                                    child: Text(Get.find<PlayersController>()
                                        .players[index]
                                        .name!),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: Get.width * 0.24,
                                child: Text(Get.find<PlayersController>()
                                    .players[index]
                                    .mobilenumber!),
                              ),
                              SizedBox(
                                width: Get.width * 0.10,
                                child: Text(Get.find<PlayersController>()
                                    .players[index]
                                    .group!),
                              ),
                            ],
                          )),
                    ),
                  ),
                );
              });
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: Get.find<PlayersController>().players.length);
      })),
    );
  }
}

void playerDelete(int index) {
  Get.find<PlayersController>()
      .players
      .remove(Get.find<PlayersController>().players[index]);
}

void playerEdit(int index) {
  Get.toNamed('/add_player_page');
  Get.find<PlayersController>().index = index;
  Get.find<PlayersController>().isedittingplayer = true;
  Get.find<AddPlayertextcontroller>().playername!.text =
      Get.find<PlayersController>().players[index].name.toString();
  Get.find<AddPlayertextcontroller>().playernumber!.text =
      Get.find<PlayersController>().players[index].mobilenumber.toString();
}
