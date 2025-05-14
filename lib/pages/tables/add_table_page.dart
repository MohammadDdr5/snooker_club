import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/classes/myconsts.dart';
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
              child: const AddTableNameText(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(15),
              child: const AddTablePriceText(),
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
                  var controller = Get.find<TableTextcontroller>();
                  controller.nameValidate.value =
                      controller.tablename!.value.text.trim().isEmpty;
                  controller.priceValidate.value =
                      controller.tableprice!.value.text.trim().isEmpty;
                  if (controller.nameValidate.value ||
                      controller.priceValidate.value) {
                  } else {
                    if (Get.find<TablesController>().iseditingtable.value ==
                        false) {
                      Get.find<TablesController>().table.add(TablesModel(
                            playerone: 'p1',
                            playertwo: 'p2',
                            name:
                                Get.find<TableTextcontroller>().tablename!.text,
                            price: Get.find<TableTextcontroller>()
                                .tableprice!
                                .text,
                            status: true,
                            time: null,
                          ));

                      Get.find<TableTextcontroller>().tablename!.clear();
                      Get.find<TableTextcontroller>().tableprice!.clear();
                      Get.back();
                      myCustomSnackbarNoIcon('tableadedsuccfullyess'.tr);
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
                      Get.find<TableTextcontroller>().tablename!.clear();
                      Get.find<TableTextcontroller>().tableprice!.clear();
                      Get.back();
                      myCustomSnackbarNoIcon('tableeditedsuccfullyess'.tr);
                    }
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

class AddTablePriceText extends StatelessWidget {
  const AddTablePriceText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextField(
        maxLength: 20,
        controller: Get.find<TableTextcontroller>().tableprice,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            errorText: Get.find<TableTextcontroller>().priceValidate.value
                ? 'cantbenull'.tr
                : null,
            hintText: 'tablepriceperhour'.tr,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      );
    });
  }
}

class AddTableNameText extends StatelessWidget {
  const AddTableNameText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextField(
        maxLength: 20,
        controller: Get.find<TableTextcontroller>().tablename,
        decoration: InputDecoration(
          errorText: Get.find<TableTextcontroller>().nameValidate.value
              ? 'cantbenull'.tr
              : null,
          hintText: 'tablename'.tr,
          fillColor: Colors.black,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.yellow,
              )),
        ),
      );
    });
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
