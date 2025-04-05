import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:snookerclub/controller/add_playertextcontroller.dart';
import 'package:snookerclub/controller/players_controller.dart';

class PlayersPage extends StatelessWidget {
  const PlayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Snooker Club'),
        backgroundColor: const Color.fromARGB(255, 101, 177, 220),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        width: Get.width,
        child: const TableListView(),
      ),
    );
  }
}

class TableListView extends StatelessWidget {
  const TableListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
        child: Obx(() {
          return ListView.separated(
              itemBuilder: (context, index) {
                return Container(
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
                          onPressed: (_) => {playerDelete(index)},
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'حذف ',
                        ),
                      ],
                    ),

                    // The end action pane is the one at the right or the bottom side.
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.
                          flex: 3,
                          onPressed: (_) {
                            Get.toNamed('/add_player_page');
                            Get.find<PlayersController>().index = index;
                            Get.find<PlayersController>().isedittingplayer =
                                true;
                            Get.find<AddPlayertextcontroller>()
                                    .playername!
                                    .text =
                                Get.find<PlayersController>()
                                    .players[index]
                                    .name
                                    .toString();
                            Get.find<AddPlayertextcontroller>()
                                    .playernumber!
                                    .text =
                                Get.find<PlayersController>()
                                    .players[index]
                                    .mobilenumber
                                    .toString();
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 234, 246, 61),
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'ویرایش',
                        ),
                      ],
                    ),

                    // The child of the Slidable is what the user sees when the
                    // component is not dragged.
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 15, left: 30, right: 30, bottom: 10),
                      width: Get.width,
                      height: 80,
                      child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.card_membership)),
                              ),
                              Text(Get.find<PlayersController>()
                                  .players[index]
                                  .name!),
                              Text(Get.find<PlayersController>()
                                  .players[index]
                                  .mobilenumber!),
                              Text(Get.find<PlayersController>()
                                  .players[index]
                                  .group!),
                            ],
                          )),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: Get.find<PlayersController>().players.length);
        }));
  }
}

void playerDelete(int index) {
  Get.find<PlayersController>()
      .players
      .remove(Get.find<PlayersController>().players[index]);
}

void playerEdit(int index) {}
