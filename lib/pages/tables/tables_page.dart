import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/controller/tables_controller.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(15),
          child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Obx(() {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            Get.find<TablesController>().table[index].name!),
                        onTap: () {
                          Get.find<TablesController>().index = index;
                          Get.toNamed('/single_table');
                        },
                        subtitle: Text(
                            Get.find<TablesController>().table[index].price!),
                        trailing: Checkbox(
                          value: true,
                          onChanged: (value) {},
                          activeColor: const Color.fromARGB(255, 16, 146, 20),
                          checkColor: Colors.white,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: const Divider(
                            color: Colors.red,
                          ));
                    },
                    itemCount: Get.find<TablesController>().table.length);
              }))),
    );
  }
}
