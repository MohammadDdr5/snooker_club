import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/classes/textstyle.dart';
import 'package:snookerclub/controller/payments_controller.dart';
import 'package:snookerclub/controller/tables_controller.dart';
import 'package:snookerclub/models/payments_model.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class SingleTable extends StatelessWidget {
  const SingleTable({super.key});

  @override
  Widget build(BuildContext context) {
    String indextablename = Get.find<TablesController>()
        .table[Get.find<TablesController>().index]
        .name!;
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('table name', style: Textstyles.redtextstyle),
                    Text('price', style: Textstyles.redtextstyle),
                    Text('status', style: Textstyles.redtextstyle),
                    Text('time', style: Textstyles.redtextstyle),
                  ],
                ),
                Column(
                  children: [
                    Text('table name', style: Textstyles.blackstyle),
                    Text('price', style: Textstyles.blackstyle),
                    Text('status', style: Textstyles.blackstyle),
                  ],
                )
              ],
            ),
            Stopwatch(),
          ]),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Stopwatch extends StatelessWidget {
  Stopwatch({super.key});
  final bool ishoures = true;
  final StopWatchTimer stopwatchtimer2 = StopWatchTimer();
  var timeforcalculate;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        child: Column(
          children: [
            StreamBuilder<int>(
                stream: stopwatchtimer2.rawTime,
                initialData: stopwatchtimer2.rawTime.value,
                builder: (context, snapshot) {
                  var value = snapshot.data;
                  var displaytime =
                      StopWatchTimer.getDisplayTime(value!, hours: ishoures);
                  timeforcalculate = displaytime;
                  return Text(displaytime);
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    stopwatchtimer2.onExecute.add(StopWatchExecute.start);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Start'),
                ),
                ElevatedButton(
                  onPressed: () {
                    stopwatchtimer2.onExecute.add(StopWatchExecute.stop);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Stop'),
                ),
                ElevatedButton(
                  onPressed: () {
                    stopwatchtimer2.onExecute.add(StopWatchExecute.reset);
                    print(timeforcalculate.toString());
                    String timefortest = '02:30:00:00';
                    //change up string name to timeforcalculate after finished the test
                    var hour =
                        int.parse(timefortest.toString().substring(0, 2));
                    var minute =
                        int.parse(timefortest.toString().substring(3, 5));
                    var price = hour * 70000 + (minute / 60) * 70000;

                    bsheettimepricecalculate(hour, minute, price);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  child: const Text('Stop and Calculate'),
                ),
              ],
            ),
          ],
        ));
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
                                tablename: ''));
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
