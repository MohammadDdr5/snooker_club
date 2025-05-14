// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:snookerclub/classes/myconsts.dart';
import 'package:snookerclub/controller/table_textcontroller.dart';
import 'package:snookerclub/controller/tables_controller.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.table_restaurant),
          actions: [languageMenu()],
          title: MyCustomAppbartitle(pagename: 'tables'.tr),
          backgroundColor: myAppbarColor,
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: Get.width * 0.18,
                        child: Text(
                          'tablename'.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Container(
                        width: Get.width * 0.18,
                        child: Text('players'.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Container(
                        width: Get.width * 0.18,
                        child: Text(
                          'price'.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Container(
                        width: Get.width * 0.12,
                        child: Text('tableactive'.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Container(
                  width: Get.width,
                  height: Get.height * 0.71,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          child: Slidable(
                            // Specify a key if the Slidable is dismissible.
                            key: UniqueKey(),

                            // The start action pane is the one at the left or the top side.
                            startActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.

                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                Container(
                                  child: SlidableAction(
                                    onPressed: (_) {
                                      if (Get.find<TablesController>()
                                              .table[index]
                                              .status ==
                                          true) {
                                        deleteTableAllert(index, context);
                                      } else {
                                        tableDelete(index);
                                      }
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'delete'.tr,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),

                            // The end action pane is the one at the right or the bottom side.
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                Container(
                                  child: SlidableAction(
                                    // An action can be bigger than the others.
                                    flex: 3,
                                    onPressed: (_) {
                                      var txtctrl =
                                          Get.find<TableTextcontroller>();
                                      var tblctrl =
                                          Get.find<TablesController>();
                                      tblctrl.iseditingtable.value = true;
                                      tblctrl.index = index;
                                      txtctrl.tablename!.text =
                                          tblctrl.table[index].name!;
                                      txtctrl.tableprice!.text =
                                          tblctrl.table[index].price!;
                                      Get.toNamed('/add_table_page');
                                    },
                                    backgroundColor:
                                        const Color.fromARGB(255, 234, 246, 61),
                                    foregroundColor:
                                        const Color.fromARGB(255, 0, 0, 0),
                                    icon: Icons.edit,
                                    label: 'edit'.tr,
                                    borderRadius: BorderRadius.circular(15),
                                    spacing: 10,
                                  ),
                                ),
                              ],
                            ),

                            // The child of the Slidable is what the user sees when the
                            // component is not dragged.
                            child: InkWell(
                              onTap: () {
                                Get.find<TablesController>().index = index;
                                if (Get.find<TablesController>()
                                        .table[index]
                                        .time ==
                                    null) {
                                  Get.find<TablesController>()
                                      .startbuttonenable
                                      .value = true;
                                  Get.find<TablesController>()
                                      .stopbuttonenable
                                      .value = false;
                                } else {
                                  Get.find<TablesController>()
                                      .startbuttonenable
                                      .value = false;
                                  Get.find<TablesController>()
                                      .stopbuttonenable
                                      .value = true;
                                }
                                Get.toNamed('/single_table');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: myAppbarColor)),
                                padding: const EdgeInsets.only(
                                    top: 15, left: 20, right: 20, bottom: 10),
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                height: Get.height * 0.083,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: Get.width * 0.18,
                                      child: Text(
                                        Get.find<TablesController>()
                                            .table[index]
                                            .name!,
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 0.18,
                                      child: Text(Get.find<TablesController>()
                                              .table[index]
                                              .playerone! +
                                          (' , ') +
                                          Get.find<TablesController>()
                                              .table[index]
                                              .playertwo!),
                                    ),
                                    Container(
                                      width: Get.width * 0.18,
                                      child: Text(
                                          style: const TextStyle(fontSize: 12),
                                          '${convertpricetocurrency(Get.find<TablesController>().table[index].price!)} ' +
                                              'moneycurrency'.tr),
                                    ),
                                    Container(
                                        width: Get.width * 0.12,
                                        child: Obx(() {
                                          return Checkbox(
                                            value: Get.find<TablesController>()
                                                        .table[index]
                                                        .time ==
                                                    null
                                                ? false
                                                : true,
                                            onChanged: (onChanged) {},
                                            activeColor: myAppbarColor,
                                          );
                                        })),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },

                      //here starts anotherone

                      separatorBuilder: (index, context) {
                        return Container(
                          margin: const EdgeInsets.only(top: 4, bottom: 4),
                          color: const Color.fromARGB(255, 190, 33, 22),
                        );
                      },
                      itemCount: Get.find<TablesController>().table.length)),
            ],
          ),
        ),

        //tables
      );
    });
  }
}

void tableDelete(int index) {
  Get.find<TablesController>()
      .table
      .remove(Get.find<TablesController>().table[index]);
}

deleteTableAllert(int index, BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('warning'.tr),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.amber,
                )
              ],
            ),
            content: Container(
              width: Get.width * 0.9,
              height: Get.height * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: Text('areyousuredelete'.tr)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: FittedBox(
                          child: IconButton(
                              onPressed: () {
                                tableDelete(index);
                                Get.back();
                              },
                              icon:
                                  const Icon(Icons.check, color: Colors.green)),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: FittedBox(
                          child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              )),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ));
}
