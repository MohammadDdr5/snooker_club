import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/controller/payments_controller.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var payment = Get.find<PaymentsController>().loserpaymoney;

    return Container(
        color: const Color.fromARGB(255, 255, 255, 255),
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
                        onLongPress: () {
                          Get.bottomSheet(Container(
                            width: Get.width,
                            height: 100,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 245, 137, 173),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text('Are You Sure he di paid That!???',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                ElevatedButton(
                                    onPressed: () {
                                      Get.snackbar("Payment",
                                          "the Payment Added too Payments list",
                                          barBlur: 50,
                                          padding: const EdgeInsets.only(
                                            top: 20,
                                            left: 20,
                                            right: 20,
                                            bottom: 20,
                                          ),
                                          margin: const EdgeInsets.only(
                                            top: 10,
                                            left: 10,
                                            right: 10,
                                          ),
                                          backgroundColor: Colors.amber);
                                      Get.close(0);
                                    },
                                    child: const Text('Yes',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold))),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'No',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          ));
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(payment[index].losername!),
                              Text(payment[index].loserpayprice!),
                              Text(payment[index].loserplayedtime!),
                              Text(payment[index].tablename!),
                            ],
                          ),
                        ))
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.lightBlueAccent,
              );
            },
            itemCount: Get.find<PaymentsController>().loserpaymoney.length,
          );
        }));
  }
}
