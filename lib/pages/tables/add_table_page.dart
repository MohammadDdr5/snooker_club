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
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: Get.find<TableTextcontroller>().tablename,
                decoration: InputDecoration(
                  hintText: 'اسم میز',
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
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: Get.find<TableTextcontroller>().tableprice,
                decoration: InputDecoration(
                    hintText: 'قیمت میز بر ساعت',
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
                    side: BorderSide(
                        style: BorderStyle.solid, color: Colors.yellow),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.black),
                onPressed: () {
                  Get.find<TablesController>().table.add(TablesModel(
                      name: Get.find<TableTextcontroller>().tablename!.text,
                      price: Get.find<TableTextcontroller>().tableprice!.text,
                      status: true));
                  Get.back();
                },
                child: const Text('افزودن میز'),
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
      margin: const EdgeInsets.only(left: 160),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Expanded(
            child: Text(
              'افزودن میز',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Hero(
            tag: 'hero',
            child: IconButton(
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
