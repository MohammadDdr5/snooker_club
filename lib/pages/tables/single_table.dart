import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/classes/textstyle.dart';
import 'package:snookerclub/controller/payments_controller.dart';
import 'package:snookerclub/controller/tables_controller.dart';
import 'package:snookerclub/models/payments_model.dart';

class SingleTable extends StatelessWidget {
  const SingleTable({super.key});

  @override
  Widget build(BuildContext context) {
    String indextablename = Get.find<TablesController>()
        .table[Get.find<TablesController>().index]
        .name!;
    DateTime starttime = DateTime.now();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(indextablename),
        ),
        body: Container(
          padding: const EdgeInsets.only(
            left: 50,
            top: 20,
            right: 50,
          ),
          margin: const EdgeInsets.all(10),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    Text('table name', style: Textstyles.redtextstyle),
                    Text('price', style: Textstyles.redtextstyle),
                    Text('status', style: Textstyles.redtextstyle),
                    Text('time', style: Textstyles.redtextstyle),
                  ],
                ),
                Column(
                  children: [
                    const Text('table name', style: Textstyles.blackstyle),
                    const Text('price', style: Textstyles.blackstyle),
                    const Text('status', style: Textstyles.blackstyle),
                    ElevatedButton(
                        onPressed: () {
                          starttime = DateTime.now();
                          var starthour = starttime.hour;
                          var startminute = starttime.minute;
                          print('$starthour   $startminute');
                        },
                        child: const Text('start')),
                    ElevatedButton(
                        onPressed: () {
                          DateTime starttimers =
                              DateTime.parse("2025-03-08 20:45:07.831216");
                          DateTime stoptimer = DateTime.now();
                          var finalstarttime = starttimers.hour.toInt() * 60 +
                              starttimers.minute.toInt();
                          var finalstoptime = stoptimer.hour.toInt() * 60 +
                              stoptimer.minute.toInt();
                          int calculatedresult = finalstoptime - finalstarttime;
                          print(calculatedresult);
                          var min = calculatedresult;
                          double hour = 0;
                          if (calculatedresult < 60) {
                            min = calculatedresult;
                          } else {
                            hour = calculatedresult / 60;
                            min = calculatedresult % (hour.toInt() * 60);
                          }
                          print(hour.toInt());

                          print(min);
                          bsheettimepricecalculate(
                              hour.toInt(), min.toInt(), 1000);
                          // print('${stoptimer.hour}  ${stoptimer.minute} ');
                        },
                        child: const Text('stop'))
                  ],
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }

  void bsheettimepricecalculate(int hour, int minute, double price) {
    TextEditingController losernamefortable = TextEditingController();
    Get.bottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              padding: const EdgeInsets.only(top: 5, right: 5),
              margin: const EdgeInsets.only(left: 5),
              width: Get.width,
              height: Get.height * 0.35,
              decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('$hour h : $minute min, price $price'),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Yes')),
                      ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('No')),
                    ],
                  ),
                  const Text(
                    'Who Lost',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 10),
                    width: Get.width,
                    height: Get.height * 0.1,
                    child: TextField(
                      controller: losernamefortable,
                      decoration: const InputDecoration(
                          hintText: 'Text',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      maxLength: 50,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.find<PaymentsController>().loserpaymoney.add(
                            PaymentsModel(
                                losername: losernamefortable.text,
                                loserpayprice: '$price',
                                loserplayedtime:
                                    '$hour hour and $minute minute',
                                tablename: Get.find<TablesController>()
                                    .table[Get.find<TablesController>().index]
                                    .name!));
                        print(Get.find<TablesController>()
                            .table[Get.find<TablesController>().index]
                            .name!);
                        Get.back();
                      },
                      child: const Text('Enter'))
                ],
              )),
        ],
      ),
    );
  }
}
