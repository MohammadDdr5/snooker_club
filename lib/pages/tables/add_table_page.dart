import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/controller/table_textcontroller.dart';
import 'package:snookerclub/controller/tables_controller.dart';
import 'package:snookerclub/models/tables_model.dart';

class AddTablePage extends StatelessWidget {
  const AddTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomAppbar(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: Get.find<TableTextcontroller>().tablename,
                decoration: InputDecoration(
                  hintText: 'tablename'.tr,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.yellow,
                      )),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: Get.find<TableTextcontroller>().tableprice,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'tablepriceperhour'.tr,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              width: Get.width,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                        style: BorderStyle.solid, color: Colors.yellow),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.black),
                onPressed: () {
                  if (Get.find<TablesController>().iseditingtable.value ==
                      false) {
                    Get.find<TablesController>().table.add(TablesModel(
                          playerone: 'p1',
                          playertwo: 'p2',
                          name: Get.find<TableTextcontroller>().tablename!.text,
                          price:
                              Get.find<TableTextcontroller>().tableprice!.text,
                          status: true,
                          time: "",
                        ));

                    Get.find<TableTextcontroller>().tablename!.text = '';
                    Get.find<TableTextcontroller>().tableprice!.text = '';
                    Get.back();
                    Get.snackbar('addtable'.tr, 'tableadedsuccfullyess'.tr,
                        margin:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        duration: const Duration(seconds: 5),
                        backgroundColor: Colors.green.shade200);
                  } else {
                    int indextble = Get.find<TablesController>().index;
                    var currenttable =
                        Get.find<TablesController>().table[indextble];
                    currenttable.name =
                        Get.find<TableTextcontroller>().tablename!.text;
                    currenttable.price =
                        Get.find<TableTextcontroller>().tableprice!.text;
                    Get.find<TablesController>().table[indextble] =
                        currenttable;
                    Get.find<TableTextcontroller>().tablename!.text = '';
                    Get.find<TableTextcontroller>().tableprice!.text = '';
                    Get.back();
                    Get.snackbar(currenttable.name.toString(),
                        'tableeditedsuccfullyess'.tr,
                        margin:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        duration: const Duration(seconds: 5),
                        backgroundColor: Colors.green.shade200);
                  }
                },
                child: Text(Get.find<TablesController>().iseditingtable.value
                    ? 'edittable'.tr
                    : 'addtable'.tr),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(),
      padding: const EdgeInsets.all(20),
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Get.find<TablesController>().iseditingtable.value
                ? 'edittable'.tr
                : 'addtable'.tr,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Hero(
            tag: 'hero',
            child: IconButton(
                color: Colors.red,
                iconSize: 40,
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close)),
          )
        ],
      ),
    );
  }
}
