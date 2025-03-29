import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:snookerclub/controller/tables_controller.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
          padding:
              const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 20),
          color: const Color.fromARGB(255, 255, 255, 255),
          child: ListView.separated(
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
                      dismissible: DismissiblePane(onDismissed: () {}),

                      // All actions are defined in the children parameter.
                      children: [
                        // A SlidableAction can have an icon and/or a label.
                        SlidableAction(
                          onPressed: (_) => {tableDelete(index)},
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
                          onPressed: (_) => {tableEdit(index)},
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
                        onTap: () {
                          Get.find<TablesController>().index = index;
                          Get.toNamed('/single_table');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Get.find<TablesController>()
                                .table[index]
                                .name!),
                            const Text('Players'),
                            Checkbox(
                              value: true,
                              onChanged: (onChanged) {},
                              activeColor: Colors.blue,
                            ),
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
                    margin: const EdgeInsets.only(left: 20),
                    child: const Divider(
                      color: Colors.red,
                    ));
              },
              itemCount: Get.find<TablesController>().table.length));
    });
  }
}

void tableDelete(int index) {
  Get.find<TablesController>()
      .table
      .remove(Get.find<TablesController>().table[index]);
}

void tableEdit(int index) {}
