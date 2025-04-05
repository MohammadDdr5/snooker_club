import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/controller/payments_controller.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var payment = Get.find<PaymentsController>().loserpaymoney;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Players Payment'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 101, 177, 220),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text('پاک کردن تاریخچه'),
                      onTap: () => {},
                    ),
                    PopupMenuItem(
                      child: const Text('تاریخچه'),
                      onTap: () {
                        Get.find<PaymentsController>().isInHistory.value = true;
                      },
                    ),
                    PopupMenuItem(
                      child: const Text('پرداحت نشده'),
                      onTap: () {
                        Get.find<PaymentsController>().isInHistory.value =
                            false;
                      },
                    ),
                  ])
        ],
      ),
      body: Container(
          padding:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Obx(() {
            if (Get.find<PaymentsController>().isInHistory.value == true) {
              List<Widget> hasti = historyNotPaidList();
              return Container(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return hasti[index];
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: hasti.length));
            } else {
              List<Widget> hasti = historyPaidList();
              return Container(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return hasti[index];
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: hasti.length));
            }
          })),
    );
  }
}

void paymentDelete(int index) {
  Get.find<PaymentsController>()
      .loserpaymoney
      .remove(Get.find<PaymentsController>().loserpaymoney[index]);
}

//for false calculator of payments
notpaidcountclaculator() {
  int count = 0;
  for (var i = 0;
      i < Get.find<PaymentsController>().loserpaymoney.length;
      i++) {
    if (Get.find<PaymentsController>().loserpaymoney[i].ispaid == false) {
      count++;
    }
  }
  return count;
}

//for true calculator of payments
paidcountclaculator() {
  int count = 0;
  for (var i = 0;
      i < Get.find<PaymentsController>().loserpaymoney.length;
      i++) {
    if (Get.find<PaymentsController>().loserpaymoney[i].ispaid == true) {
      count++;
    }
  }
  return count;
}

notpaiditemlisted() {
  int lengthitem = Get.find<PaymentsController>().loserpaymoney.length;
  var list = [];
  for (var i = 0; i < lengthitem; i++) {
    if (Get.find<PaymentsController>().loserpaymoney[i].ispaid == false) {
      list.add(i);
    }
  }
  return list;
}

paiditemlisted() {
  int lengthitem = Get.find<PaymentsController>().loserpaymoney.length;
  var list = [];
  for (var i = 0; i < lengthitem; i++) {
    if (Get.find<PaymentsController>().loserpaymoney[i].ispaid == true) {
      list.add(i);
    }
  }
  return list;
}

//Making Payment List For Payment History Palyers Not Paid Yet
historyNotPaidList() {
  List<Widget>? widgetlist = List.generate(0, (index) => Container());

  for (var element in notpaiditemlisted()) {
    widgetlist.add(singlenotpaidlist(element));
  }

  return widgetlist;
}

singlenotpaidlist(int indexlist) {
  if (Get.find<PaymentsController>().loserpaymoney[indexlist].ispaid == false) {
    return Container(
      height: 70,
      color: const Color.fromARGB(255, 235, 70, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(Get.find<PaymentsController>()
              .loserpaymoney[indexlist]
              .losername!),
          Text(Get.find<PaymentsController>()
              .loserpaymoney[indexlist]
              .loserpayprice!),
          Text(Get.find<PaymentsController>()
              .loserpaymoney[indexlist]
              .tablename!),
          Text('$indexlist'),
          Text(Get.find<PaymentsController>()
              .loserpaymoney[indexlist]
              .ispaid
              .toString())
        ],
      ),
    );
  }
}

//Payment Paid History List

historyPaidList() {
  List<Widget> widgetlist = List.generate(
      0,
      (index) => Container(
            child: Container(),
          ));

  for (var element in paiditemlisted()) {
    widgetlist.add(singlePaidList(element));
  }

  return widgetlist;
}

singlePaidList(int indexlist) {
  if (Get.find<PaymentsController>().loserpaymoney[indexlist].ispaid == true) {
    return Container(
      height: 70,
      color: const Color.fromARGB(255, 42, 175, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(Get.find<PaymentsController>()
              .loserpaymoney[indexlist]
              .losername!),
          Text(Get.find<PaymentsController>()
              .loserpaymoney[indexlist]
              .loserpayprice!),
          Text(Get.find<PaymentsController>()
              .loserpaymoney[indexlist]
              .tablename!),
          Text('$indexlist'),
          Text(Get.find<PaymentsController>()
              .loserpaymoney[indexlist]
              .ispaid
              .toString())
        ],
      ),
    );
  }
}
