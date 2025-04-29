import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:snookerclub/classes/myconsts.dart';
import 'package:snookerclub/controller/tables_controller.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: MyCustomAppbartitle(pagename: 'tablespage'.tr),
          backgroundColor: myAppbarColor,
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: Get.height * 0.07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: Get.width * 0.18,
                        child: Text(
                          'tablename'.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.18,
                        child: Text('players'.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      SizedBox(
                        width: Get.width * 0.18,
                        child: Text('tableactive'.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              SizedBox(
                  width: Get.width,
                  height: Get.height * 0.71,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return SizedBox(
                          child: Slidable(
                            // Specify a key if the Slidable is dismissible.
                            key: const ValueKey(0),

                            // The start action pane is the one at the left or the top side.
                            startActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              dismissible: DismissiblePane(onDismissed: () {
                                tableDelete(index);
                              }),

                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SizedBox(
                                  child: SlidableAction(
                                    onPressed: (_) => {tableDelete(index)},
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
                                SlidableAction(
                                  // An action can be bigger than the others.
                                  flex: 3,
                                  onPressed: (_) {
                                    Get.find<TablesController>()
                                        .iseditingtable
                                        .value = true;
                                    Get.find<TablesController>().index = index;
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
                                    "") {
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
                                    SizedBox(
                                      width: Get.width * 0.18,
                                      child: Text(
                                        Get.find<TablesController>()
                                            .table[index]
                                            .name!,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.18,
                                      child: Text(Get.find<TablesController>()
                                              .table[index]
                                              .playerone! +
                                          (',') +
                                          Get.find<TablesController>()
                                              .table[index]
                                              .playertwo!),
                                    ),
                                    SizedBox(
                                        width: Get.width * 0.18,
                                        child: Obx(() {
                                          return Checkbox(
                                            value: Get.find<TablesController>()
                                                        .table[index]
                                                        .time ==
                                                    ""
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
