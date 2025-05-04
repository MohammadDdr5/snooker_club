// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/classes/myconsts.dart';
import 'package:snookerclub/controller/payments_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.payment),
        title: MyCustomAppbartitle(pagename: 'paymentsbills'.tr),
        backgroundColor: myAppbarColor,
        actions: [
          languageMenu(),
          paymentPopupMenu(),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: Get.width * 0.18,
                      child: Text(
                        'loser'.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Container(
                      width: Get.width * 0.18,
                      child: Text('tablename'.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    Container(
                      width: Get.width * 0.18,
                      child: Text('date'.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    Container(
                      width: Get.width * 0.10,
                      child: Text(
                        'price'.tr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                height: Get.height * 0.71,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Obx(() {
                  if (Get.find<PaymentsController>().isInHistory.value ==
                      true) {
                    List<Widget> payments = historynotPaidList();
                    return Container(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return payments[index];
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: payments.length));
                  } else {
                    List<Widget> payments = historyPaidList();
                    return Container(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return payments[index];
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: payments.length));
                  }
                })),
          ],
        ),
      ),
    );
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
  historyPaidList() {
    List<Widget>? widgetlist = List.generate(0, (index) => Container());

    for (var element in paiditemlisted()) {
      widgetlist.add(singlepaidlist(element));
    }

    return widgetlist;
  }

  singlepaidlist(int indexlist) {
    if (Get.find<PaymentsController>().loserpaymoney[indexlist].ispaid ==
        true) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.lightGreen.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: Get.width * 0.2,
              child: Text(Get.find<PaymentsController>()
                  .loserpaymoney[indexlist]
                  .losername!),
            ),
            Container(
              width: Get.width * 0.2,
              child: Text(Get.find<PaymentsController>()
                  .loserpaymoney[indexlist]
                  .tablename!),
            ),
            Container(
              width: Get.width * 0.2,
              child: Text(Get.find<PaymentsController>()
                  .loserpaymoney[indexlist]
                  .paymentdatetime!),
            ),
            Container(
              width: Get.width * 0.2,
              child: Text(
                convertpricetocurrency(Get.find<PaymentsController>()
                    .loserpaymoney[indexlist]
                    .loserpayprice!),
              ),
            )
          ],
        ),
      );
    }
  }

//Payment Paid History List

  historynotPaidList() {
    List<Widget> widgetlist = List.generate(0, (index) => Container());

    for (var element in notpaiditemlisted()) {
      widgetlist.add(singlenotPaidList(element));
    }

    return widgetlist;
  }

  singlenotPaidList(int indexlist) {
    var payment = Get.find<PaymentsController>().loserpaymoney;
    if (Get.find<PaymentsController>().loserpaymoney[indexlist].ispaid ==
        false) {
      return Container(
        child: Slidable(
          // Specify a key if the Slidable is dismissible.
          key: UniqueKey(),

          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.
            dismissible: DismissiblePane(onDismissed: () {
              paymentDelete(indexlist);
            }),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: (_) => {paymentDelete(indexlist)},
                backgroundColor: const Color.fromARGB(255, 187, 39, 39),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'delete'.tr,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
            ],
          ),

          // The end action pane is the one at the right or the bottom side.
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              Container(
                child: SlidableAction(
                  // An action can be bigger than the others.
                  flex: 3,
                  onPressed: (_) {
                    var currentloserpay =
                        Get.find<PaymentsController>().loserpaymoney[indexlist];

                    currentloserpay.ispaid = true;
                    Get.find<PaymentsController>().loserpaymoney[indexlist] =
                        currentloserpay;
                  },

                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  backgroundColor: const Color.fromARGB(255, 234, 246, 61),
                  foregroundColor: Colors.black,
                  icon: Icons.payment_rounded,
                  label: 'paid'.tr,
                ),
              ),
            ],
          ),

          // The child of the Slidable is what the user sees when the
          // component is not dragged.
          child: InkWell(
            onTap: () {},
            child: Container(
              color: const Color.fromARGB(255, 243, 162, 162),
              padding: const EdgeInsets.only(
                  top: 15, left: 15, right: 15, bottom: 10),
              width: Get.width,
              height: Get.height * 0.085,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width * 0.18,
                    child: Text(
                      payment[indexlist].losername!,
                    ),
                  ),
                  Container(
                      width: Get.width * 0.18,
                      child: Text(payment[indexlist].tablename!)),
                  Container(
                    width: Get.width * 0.18,
                    child: Text(payment[indexlist].paymentdatetime.toString()),
                  ),
                  Container(
                      width: Get.width * 0.18,
                      child: Text(
                          '${convertpricetocurrency(payment[indexlist].loserpayprice!)} تومان'))
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

//convert price to currency price
  convertpricetocurrency(String price) {
    var pricereverce = '';
    int counter = 0;
    for (var i = price.length; i > 0; i--) {
      pricereverce += price.substring(i - 1, i);
      counter++;
      if (counter == price.length) {
        break;
      }
      if (counter == 3) {
        pricereverce += ',';
      } else if (counter == 6) {
        pricereverce += ',';
      }
    }

    var finalreversed = '';
    for (var i = pricereverce.length; i > 0; i--) {
      finalreversed += pricereverce.substring(i - 1, i);
    }
    return finalreversed;
  }

  paidHistoryCleaner() async {
    var thispayment = Get.find<PaymentsController>();
    var list = Get.find<PaymentsController>().loserpaymoney.toList();
    for (var item in list) {
      if (item.ispaid == true) {
        thispayment.loserpaymoney.remove(item);
      }
    }
  }

  //payment popupmenuitems
  paymentPopupMenu() {
    return PopupMenuButton(
        offset: const Offset(5, 55),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('clearpaymentshistory'.tr),
                onTap: () {
                  showDialog(
                      context: (context),
                      builder: (_) {
                        return AlertDialog(
                          content: Container(
                            height: Get.height * 0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Container(
                                    width: Get.width * 0.8,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'areyousuretodelete'.tr,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Icon(
                                                  Icons.error_outline),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                await paidHistoryCleaner();
                                                Get.back();
                                              },
                                              child: const Icon(
                                                  Icons.done_outline_outlined),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
              PopupMenuItem(
                child: Text('paymenthistory'.tr),
                onTap: () {
                  Get.find<PaymentsController>().isInHistory.value = false;
                },
              ),
              PopupMenuItem(
                child: Text('payment'.tr),
                onTap: () {
                  Get.find<PaymentsController>().isInHistory.value = true;
                },
              ),
            ]);
  }
}

//payment paid history delete

