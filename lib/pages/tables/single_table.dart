// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/classes/myconsts.dart';
import 'package:snookerclub/controller/payments_controller.dart';
import 'package:snookerclub/controller/tables_controller.dart';
import 'package:snookerclub/controller/tblsubplayerstxtcntrlr.dart';
import 'package:snookerclub/controller/themeandlang_controller.dart';
import 'package:snookerclub/models/payments_model.dart';
import 'package:snookerclub/models/tables_model.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

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
          backgroundColor: myAppbarColor,
          centerTitle: true,
          title: Text(
            currenttable.name.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(
            left: 5,
            top: 20,
            right: 5,
          ),
          margin: const EdgeInsets.all(5),
          child: Column(children: [
            Obx(() {
              return Container(
                height: Get.height * 0.2,
                width: Get.width * 0.9,
                child: DataTable(
                  columns: showPlayersdetailtable,
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Obx(() {
                          return Get.find<TablesController>()
                                      .table[indextable]
                                      .time ==
                                  null
                              ? const Text('')
                              : Text(Get.find<TablesController>()
                                  .table[indextable]
                                  .time
                                  .toString()
                                  .substring(11, 19));
                        })),
                        DataCell(
                            Get.find<TablesController>()
                                        .table[indextable]
                                        .playerone !=
                                    'p1'
                                ? Text(Get.find<TablesController>()
                                    .table[indextable]
                                    .playerone!)
                                : const Center(
                                    child: Icon(Icons.add_circle_rounded),
                                  ), onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    content: addplayerbttonsheet(1, indextable),
                                  ));
                        }),
                        DataCell(
                            Get.find<TablesController>()
                                        .table[indextable]
                                        .playertwo !=
                                    'p2'
                                ? Text(Get.find<TablesController>()
                                    .table[indextable]
                                    .playertwo!)
                                : const Center(
                                    child: Icon(Icons.add_circle_rounded),
                                  ), onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    content: addplayerbttonsheet(2, indextable),
                                  ));
                        }),
                      ],
                    ),
                  ],
                ),
              );
            }),
            Obx(() {
              return Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        startButton(starttime, currenttable, indextable),
                        endButton(indextable, startbutton),
                        openCloseButton(indextable, startbutton),
                      ],
                    ),
                  ),
                  Obx(() {
                    return Container(
                      child: Get.find<TablesController>()
                                  .table[Get.find<TablesController>().index]
                                  .time !=
                              null
                          ? Container(
                              margin: const EdgeInsets.only(top: 15),
                              height: Get.height * 0.1,
                              width: Get.width * 0.9,
                              child: const Stopwatch(),
                            )
                          : Container(),
                    );
                  }),
                ],
              );
            })
          ]),
        ),
      ),
    );
  }

  List<DataColumn> get showPlayersdetailtable {
    return <DataColumn>[
      DataColumn(
        label: Center(
            child: Text('starttime'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold))),
      ),
      DataColumn(
        label: Center(
            child: Text('playerone'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold))),
      ),
      DataColumn(
        label: Center(
            child: Text('playertwo'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold))),
      ),
    ];
  }

  ElevatedButton openCloseButton(int indextable, bool startbutton) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
        onPressed: Get.find<TablesController>().stopbuttonenable.value == false
            ? null
            : () {
                int calculatedresult = endGameCalculator();
                var min = calculatedresult;
                double hour = 0;
                if (calculatedresult < 60) {
                  min = calculatedresult;
                } else {
                  hour = calculatedresult / 60;
                  min = calculatedresult % (hour.toInt() * 60);
                }

                bsheettimepricecalculate(
                    hour.toInt(),
                    min.toInt(),
                    double.parse((Get.find<TablesController>()
                        .table[indextable]
                        .price!)),
                    true);

                // print('${stoptimer.hour}  ${stoptimer.minute} ');
              },
        child: Text(
          'openclose'.tr,
          style: const TextStyle(color: Colors.black),
        ));
  }

  ElevatedButton endButton(int indextable, bool startbutton) {
    return ElevatedButton(
        style:
            ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
        onPressed: Get.find<TablesController>().stopbuttonenable.value == false
            ? null
            : () {
                int calculatedresult = endGameCalculator();
                var min = calculatedresult;
                double hour = 0;
                if (calculatedresult < 60) {
                  min = calculatedresult;
                } else {
                  hour = calculatedresult / 60;
                  min = calculatedresult % (hour.toInt() * 60);
                }

                bsheettimepricecalculate(
                    hour.toInt(),
                    min.toInt(),
                    double.parse((Get.find<TablesController>()
                        .table[indextable]
                        .price!)),
                    false);
                // print('${stoptimer.hour}  ${stoptimer.minute} ');
              },
        child: Text(
          'endgame'.tr,
          style: const TextStyle(color: Colors.black),
        ));
  }

  ElevatedButton startButton(
      DateTime starttime, TablesModel currenttable, int indextable) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
        ),
        onPressed: Get.find<TablesController>().startbuttonenable.value == false
            ? null
            : () {
                currenttable.time = DateTime.now().toString();
                Get.find<TablesController>().table[indextable] = currenttable;
                Get.find<TablesController>().startbuttonenable.value = false;
                Get.find<TablesController>().stopbuttonenable.value = true;
              },
        child: Text(
          'startgame'.tr,
          style: const TextStyle(color: Colors.black),
        ));
  }

  void bsheettimepricecalculate(
      int hour, int minute, double price, bool isopenclosebutton) {
    TextEditingController losernamefortable = TextEditingController();

    Get.bottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              padding: const EdgeInsets.only(
                  top: 15, right: 20, bottom: 30, left: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              width: Get.width,
              height: Get.height * 0.35,
              decoration: BoxDecoration(
                  color: Get.find<ThemeandlangController>().isthemedark.value
                      ? Colors.black
                      : Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  border: Border.all(color: Colors.blueAccent)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  timeandPriceShow(hour, minute, price),
                  playersloserselected(losernamefortable),
                  enterButton(losernamefortable, price, hour, minute,
                      isopenclosebutton),
                ],
              )),
        ],
      ),
    );
  }

  Row timeandPriceShow(int hour, int minute, double price) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(' Hour $hour, $minute minute , price $price'),
      ],
    );
  }

  Container playersloserselected(TextEditingController losernamefortable) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Get.find<TablesController>()
                      .table[Get.find<TablesController>().index]
                      .playerone !=
                  'p1' ||
              Get.find<TablesController>()
                      .table[Get.find<TablesController>().index]
                      .playertwo !=
                  'p2'
          ? rowChips()
          : whoLostTextField(losernamefortable),
    );
  }

  Container whoLostTextField(TextEditingController losernamefortable) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      width: Get.width,
      height: Get.height * 0.1,
      child: TextField(
        controller: losernamefortable,
        decoration: InputDecoration(
            hintText: 'wholostgame'.tr,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
        maxLength: 50,
      ),
    );
  }

  Container enterButton(TextEditingController losernamefortable, double price,
      int hour, int minute, bool isopencloseclicked) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: Get.height * 0.08,
      width: Get.width * 0.7,
      child: Expanded(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              double calculatedprice =
                  hour * (price * 1000) + (minute / 60) * (price * 1000);
              int pricetoint = calculatedprice.round();
              Get.find<PaymentsController>().loserpaymoney.add(PaymentsModel(
                  paymentdatetime: DateTime.now().toString(),
                  ispaid: false,
                  losername: Get.find<TablesController>().wholost.value != ''
                      ? Get.find<TablesController>().wholost.value
                      : losernamefortable.text,
                  loserpayprice: '$pricetoint',
                  loserplayedtime: '$hour hour and $minute minute',
                  tablename: Get.find<TablesController>()
                      .table[Get.find<TablesController>().index]
                      .name!));
              if (isopencloseclicked) {
                int indextbl = Get.find<TablesController>().index;
                var currenttable = Get.find<TablesController>().table[indextbl];
                currenttable.time = DateTime.now().toString();
                Get.find<TablesController>().table[indextbl] = currenttable;

                Get.back();
                Get.rawSnackbar(
                    message: 'endgametablemassage'.tr,
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    duration: const Duration(seconds: 5),
                    snackPosition: SnackPosition.TOP,
                    borderRadius: 20);

                Get.find<TablesController>().stopbuttonenable.value = true;
              } else {
                Get.find<TablesController>()
                    .table[Get.find<TablesController>().index]
                    .time = null;
                Get.find<TablesController>().startbuttonenable.value = true;

                Get.find<TablesController>().stopbuttonenable.value = false;
                Get.find<TablesController>().closeopenbutton.value = false;
                Get.find<TablesController>()
                    .table[Get.find<TablesController>().index]
                    .time = null;
                Get.find<TablesController>().wholost.value = '';
                Get.find<TablesController>()
                    .table[Get.find<TablesController>().index]
                    .playerone = 'p1';
                Get.find<TablesController>()
                    .table[Get.find<TablesController>().index]
                    .playertwo = 'p2';
                Get.back();
                Get.rawSnackbar(
                  snackStyle: SnackStyle.FLOATING,
                  messageText: Container(
                      padding: const EdgeInsets.only(left: 100, right: 100),
                      child: Text(
                        'endgametablemassage'.tr,
                        style: const TextStyle(color: Colors.white),
                      )),
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  duration: const Duration(seconds: 5),
                  snackPosition: SnackPosition.TOP,
                  borderRadius: 20,
                );
                var tblctrl = Get.find<TablesController>();
                tblctrl.startbuttonenable.value = true;
                tblctrl.stopbuttonenable.value = false;
                var thistable = tblctrl.table[tblctrl.index];
                thistable.time = null;
                tblctrl.table[tblctrl.index] = thistable;
              }
            },
            child: Text(
              'submit'.tr,
              style: const TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}

//Stopwatchtimer
class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> {
  final StopWatchTimer _stopwatchtimer = StopWatchTimer();
  final ishoures = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: myAppbarColor),
        width: Get.width * 0.9,
        height: Get.height * 0.2,
        child: StreamBuilder<int>(
            stream: _stopwatchtimer.rawTime,
            initialData: _stopwatchtimer.rawTime.value,
            builder: (context, snapshot) {
              var tabletimetodate = Get.find<TablesController>()
                  .table[Get.find<TablesController>().index]
                  .time;

              var timerdiffrence =
                  DateTime.now().difference(DateTime.parse(tabletimetodate!));

              var value = StopWatchTimer.getMilliSecFromSecond(
                  timerdiffrence.inSeconds);

              var displaytime =
                  StopWatchTimer.getDisplayTime(value, hours: ishoures);

              _stopwatchtimer.onExecute.add(StopWatchExecute.start);
              return Text(displaytime.toString(),
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold));
            }));
  }
}

addplayerbttonsheet(int playernumber, int indextable) {
  return Container(
    width: Get.width * 0.9,
    height: Get.height * 0.25,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: Get.width * 0.8,
            height: Get.height * 0.1,
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: TextField(
              controller: playernumber == 1
                  ? Get.find<Tblsubplayerstxtcntrlr>().playerone
                  : Get.find<Tblsubplayerstxtcntrlr>().playertwo,
              maxLines: 20,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  focusColor: Colors.blueAccent,
                  hintText: 'playername'.tr),
            )),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            margin: const EdgeInsets.only(top: 20),
            height: Get.height * 0.06,
            width: Get.width * 0.8,
            child: ElevatedButton(
              onPressed: () {
                var thistable = Get.find<TablesController>().table[indextable];
                var playersCtrler = Get.find<Tblsubplayerstxtcntrlr>();
                if (playernumber == 1) {
                  thistable.playerone =
                      playersCtrler.playerone!.text.toString();
                  Get.find<TablesController>().table[indextable] = thistable;
                  playersCtrler.playerone!.clear();
                  Get.back();
                } else {
                  thistable.playertwo =
                      playersCtrler.playertwo!.text.toString();
                  Get.find<TablesController>().table[indextable] = thistable;
                  playersCtrler.playertwo!.clear();
                  Get.back();
                }
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue),
              child: Text('submit'.tr),
            )),
      ],
    ),
  );
}

//two next widgets Forplayers select in bottonsheet
rowChips() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      chipForRow(
          Get.find<TablesController>()
              .table[Get.find<TablesController>().index]
              .playerone!,
          Colors.green),
      chipForRow(
          Get.find<TablesController>()
              .table[Get.find<TablesController>().index]
              .playertwo!,
          Colors.green),
    ],
  );
}

Widget chipForRow(String label, Color color) {
  return Container(
    margin: const EdgeInsets.all(6.0),
    child: GestureDetector(
      onTap: () {
        Get.find<TablesController>().wholost.value = label;
      },
      child: Chip(
        labelPadding: const EdgeInsets.all(5.0),
        avatar: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 240, 237, 237),
            child: Text(label[0].toUpperCase())),
        label: Text(
          label,
          style: const TextStyle(
            color: Color.fromARGB(255, 10, 10, 10),
          ),
          selectionColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        backgroundColor: color,
        elevation: 6.0,
        shadowColor: Colors.grey[60],
        padding: const EdgeInsets.all(6.0),
      ),
    ),
  );
}

//End Game Calculator method
endGameCalculator() {
  var starttimehour = 0;
  var stoptimerhour = 0;
  var starttimer = Get.find<TablesController>()
      .table[Get.find<TablesController>().index]
      .time
      .toString();
  DateTime stoptimer = DateTime.now();
  if (starttimer.substring(11, 13) != '00') {
    starttimehour = int.parse(starttimer.substring(11, 13)) * 60;
  } else {
    starttimehour = int.parse(starttimer.substring(11, 13));
  }
  if (stoptimer.hour != 0) {
    stoptimerhour = stoptimer.hour * 60;
  }

  var starttimerfinal = starttimehour + int.parse(starttimer.substring(14, 16));
  var stoptimerfinal = stoptimerhour + stoptimer.minute;
  // ignore: unused_local_variable
  int calculatedresult = 0;
  if (starttimerfinal > stoptimerfinal) {
    return calculatedresult = (24 * 60) - starttimerfinal + stoptimerfinal;
  } else {
    return calculatedresult = stoptimerfinal - starttimerfinal;
  }
}

//start time fill and calculate
startTimeFillCal() {
  var starttime = DateTime.now();
  String starthour = '0';
  String startminute = '0';
  if (starttime.hour.toString().length <= 1) {
    starthour = ('0') + (starttime.hour.toString());
  } else {
    starthour = starttime.hour.toString();
  }
  if (starttime.minute.toString().length <= 1) {
    startminute = ('0') + (startminute.toString());
  } else {
    startminute = starttime.minute.toString();
  }
  return starthour + (':') + startminute;
}
