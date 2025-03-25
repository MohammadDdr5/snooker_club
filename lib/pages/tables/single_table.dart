import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:snookerclub/controller/payments_controller.dart';
import 'package:snookerclub/controller/tables_controller.dart';
import 'package:snookerclub/models/payments_model.dart';

class SingleTable extends StatelessWidget {
  const SingleTable({super.key});

  @override
  Widget build(BuildContext context) {
    int indextable = Get.find<TablesController>().index;

    var currenttable = Get.find<TablesController>().table[indextable];
    DateTime starttime = DateTime.now();
    bool startbutton = true;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(currenttable.name.toString()),
        ),
        body: Container(
          padding: const EdgeInsets.only(
            left: 5,
            top: 20,
            right: 5,
          ),
          margin: const EdgeInsets.all(5),
          child: Column(children: [
            Container(
              height: 200,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Expanded(
                        child: Text('اسم میز',
                            style: TextStyle(fontStyle: FontStyle.italic))),
                  ),
                  DataColumn(
                    label: Expanded(
                        child: Text('تایم شروع',
                            style: TextStyle(fontStyle: FontStyle.italic))),
                  ),
                  DataColumn(
                    label: Expanded(
                        child: Text('بازیکن یک',
                            style: TextStyle(fontStyle: FontStyle.italic))),
                  ),
                  DataColumn(
                    label: Expanded(
                        child: Text('بازیکن دو',
                            style: TextStyle(fontStyle: FontStyle.italic))),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text('نام میز')),
                      DataCell(Obx(() {
                        return Text(Get.find<TablesController>()
                            .table[indextable]
                            .time
                            .toString());
                      })),
                      const DataCell(Text('بازیکن یک')),
                      const DataCell(Text('بازیکن دو')),
                    ],
                  ),
                ],
              ),
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent),
                      onPressed: Get.find<TablesController>()
                                  .startbuttonenable ==
                              false
                          ? null
                          : () {
                              starttime = DateTime.now();
                              var starthour = starttime.hour;
                              var startminute = starttime.minute;
                              currenttable.time = starthour.toString() +
                                  ':' +
                                  startminute.toString();
                              Get.find<TablesController>().table[indextable] =
                                  currenttable;
                              Get.find<TablesController>()
                                      .startbuttonenable
                                      .value =
                                  !Get.find<TablesController>()
                                      .startbuttonenable
                                      .value;
                              Get.find<TablesController>()
                                      .stopbuttonenable
                                      .value =
                                  !Get.find<TablesController>()
                                      .stopbuttonenable
                                      .value;

                              ;

                              print('$starthour   $startminute');
                            },
                      child: const Text('َشروع بازی')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent),
                      onPressed: Get.find<TablesController>()
                                  .stopbuttonenable ==
                              false
                          ? null
                          : () {
                              DateTime starttimers =
                                  DateTime.parse("2025-03-08 20:45:07.831216");
                              DateTime stoptimer = DateTime.now();
                              var finalstarttime =
                                  starttimers.hour.toInt() * 60 +
                                      starttimers.minute.toInt();
                              var finalstoptime = stoptimer.hour.toInt() * 60 +
                                  stoptimer.minute.toInt();
                              int calculatedresult =
                                  finalstoptime - finalstarttime;
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
                              startbutton = true;
                              print(min);
                              bsheettimepricecalculate(
                                  hour.toInt(), min.toInt(), 1000);
                              // print('${stoptimer.hour}  ${stoptimer.minute} ');
                            },
                      child: const Text('اتمام بازی')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                      onPressed: () {},
                      child: const Text('باز و بست میز'))
                ],
              );
            })
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
                  color: Colors.lightBlueAccent,
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
                        Get.find<TablesController>()
                            .table[Get.find<TablesController>().index]
                            .time = '';
                        Get.find<TablesController>().startbuttonenable.value =
                            true;
                      },
                      child: const Text('Enter'))
                ],
              )),
        ],
      ),
    );
  }
}
