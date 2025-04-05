//delete listview seprated from this page try it on homepage(games_page)
//thisngs working good
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/controller/payments_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

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
                      child: const Text('پرداخت نشده ها'),
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
            return ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 227, 86, 76)),
                    child: Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(0),

                      // The start action pane is the one at the left or the top side.
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(onDismissed: () {}),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (_) => {paymentDelete(index)},
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'حذف ',
                          ),
                        ],
                      ),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            flex: 3,
                            onPressed: (_) {
                              var currentloserpay =
                                  Get.find<PaymentsController>()
                                      .loserpaymoney[index];

                              currentloserpay.ispaid = true;
                              Get.find<PaymentsController>()
                                  .loserpaymoney[index] = currentloserpay;
                            },
                            backgroundColor:
                                const Color.fromARGB(255, 234, 246, 61),
                            foregroundColor: Colors.black,
                            icon: Icons.edit,
                            label: 'پرداخت شد',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: Container(
                          padding: const EdgeInsets.only(
                              top: 15, left: 30, right: 30, bottom: 10),
                          width: Get.width,
                          height: 80,
                          child: InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(payment[index].losername!),
                                  Text(payment[index].tablename!),
                                  Text(payment[index].loserpayprice!),
                                  Text(ispaidcountclaculatorfalse().toString()),
                                  Text(ispaidcountclaculatortrue().toString()),
                                  Text('$index'),
                                  Text(payment[index].ispaid.toString()),
                                  Text(notpaiditemlisted().toString()),
                                  Checkbox(
                                    value: true,
                                    onChanged: (onChanged) {},
                                    activeColor: Colors.blue,
                                  ),
                                ],
                              ))),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 35, right: 35),
                    child: const Divider(
                      color: Colors.lightBlueAccent,
                    ),
                  );
                },
                itemCount: Get.find<PaymentsController>().loserpaymoney.length);
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
ispaidcountclaculatorfalse() {
  int count = 0;
  if (Get.find<PaymentsController>().loserpaymoney.isEmpty) {
    return null;
  } else {
    for (var i = 0;
        i < Get.find<PaymentsController>().loserpaymoney.length;
        i++) {
      if (Get.find<PaymentsController>().loserpaymoney[i].ispaid == false) {
        count++;
      }
    }
  }
  return count;
}

//for true calculator of payments
ispaidcountclaculatortrue() {
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

donothing() {}
