//gamepage extra coeds for test

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/classes/myconsts.dart';
import 'package:snookerclub/controller/add_playertextcontroller.dart';
import 'package:snookerclub/controller/payments_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:snookerclub/controller/players_controller.dart';
import 'package:snookerclub/controller/tables_controller.dart';

import 'package:snookerclub/controller/themeandlang_controller.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const MyCustomAppbartitle(pagename: 'Games')),
        body: SizedBox(
            child: Table(
          children: [
            TableRow(children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'tablename'.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'players'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'activate'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ]),
            for (var item in Get.find<TablesController>().table)
              TableRow(children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      item.name!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      '${item.playerone} , ${item.playertwo}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child:
                          Checkbox(value: item.status, onChanged: (_) => {})),
                ),
              ])
          ],
        )));
  }
}

//mytablerow list

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
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color:
                            Get.find<ThemeandlangController>().isthemedark.value
                                ? const Color.fromARGB(255, 77, 71, 71)
                                : const Color.fromARGB(255, 232, 225, 225),
                        spreadRadius: 1,
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
                                    onPressed: () {
                                      var price = Get.find<PaymentsController>()
                                          .loserpaymoney[1]
                                          .loserpayprice;

                                      String jrc = '80000000';
                                    },
                                    icon: const Icon(Icons.person_outlined)),
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

convertpricetocurrency(String price) {
  var pricereverce = '';
  int counter = 0;
  for (var i = price.length; i > 0; i--) {
    pricereverce += price.substring(i - 1, i);
    counter++;
    if (counter == 3) {
      pricereverce += ',';
    } else if (counter == 6) {
      pricereverce += ',';
    }
  }

  var finalreversed = '';
  for (var i = pricereverce.length; i > 0; i--) {
    finalreversed += pricereverce.substring(i - 1, i);
  }
  return finalreversed;
}

//
Widget _getData01(List listOfData) {
  List<DataRow> rows = [];

  listOfData.forEach((stat) {
    stat.item.forEach((row) {
      rows.add(DataRow(cells: [
        DataCell(
          Text(row.symbol),
        ),
        DataCell(
          Text(row.amount),
        ),
        DataCell(
          Text("${row.symbol}"),
        ),
      ]));
    });
  });

  return DataTable(
    columns: listOfData
        .map((column) => DataColumn(
              label: Container(),
            ))
        .toList(),
    rows: rows,
  );
}
