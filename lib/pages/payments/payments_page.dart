import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/controller/payments_controller.dart';
import 'package:snookerclub/controller/table_textcontroller.dart';
import 'package:snookerclub/controller/tables_controller.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var payment = Get.find<PaymentsController>().loserpaymoney;

    return Container(
        color: const Color.fromARGB(255, 135, 173, 238),
        child: Obx(() {
          return ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(payment[index].losername!),
                          Text(payment[index].loserpayprice!),
                          Text(payment[index].loserplayedtime!),
                          Text(payment[index].tablename!),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.red,
              );
            },
            itemCount: Get.find<PaymentsController>().loserpaymoney.length,
          );
        }));
  }
}
