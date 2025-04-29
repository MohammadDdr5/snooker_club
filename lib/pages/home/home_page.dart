import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/controller/home_controller.dart';
import 'package:snookerclub/controller/players_controller.dart';
import 'package:snookerclub/controller/tables_controller.dart';
import 'package:snookerclub/controller/themeandlang_controller.dart';
import 'package:snookerclub/pages/news/news_page.dart';
import 'package:snookerclub/pages/players/players_page.dart';
import 'package:snookerclub/pages/payments/payments_page.dart';
import 'package:snookerclub/pages/tables/tables_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
          floatingActionButton: Tooltip(
            message:
                'To Add Player And Table To List, Stay On the Page And Click Here',
            child: FloatingActionButton(
              elevation: 10,
              heroTag: 'hero',
              mini: true,
              backgroundColor: const Color.fromARGB(255, 13, 66, 181),

              onPressed: () {
                if (controller.index == 0) {
                  Get.toNamed('/add_table_page');
                  Get.find<TablesController>().iseditingtable.value = false;
                } else if (controller.index == 1) {
                  Get.toNamed('/add_player_page');
                  Get.find<PlayersController>().isedittingplayer = false;
                }
              },

              child: const Icon(Icons.add),
              //params
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          bottomNavigationBar: Obx(() {
            return CurvedNavigationBar(
              backgroundColor: Colors.blueAccent,
              color: Get.find<ThemeandlangController>().isthemedark.value
                  ? Colors.black
                  : Colors.white,
              items: [
                CurvedNavigationBarItem(
                  child: const Icon(Icons.table_restaurant_outlined),
                  label: 'tables'.tr,
                ),
                CurvedNavigationBarItem(
                  child: const Icon(Icons.person_2_outlined),
                  label: 'players'.tr,
                ),
                CurvedNavigationBarItem(
                  child: const Icon(Icons.payment_outlined),
                  label: 'payment'.tr,
                ),
                CurvedNavigationBarItem(
                  child: const Icon(Icons.newspaper_outlined),
                  label: 'news'.tr,
                ),
              ],
              onTap: (index) {
                controller.changetap(index);
              },
            );
          }),
          // ignore: deprecated_member_use
          body: WillPopScope(
            onWillPop: onWillPop,
            child: IndexedStack(
              index: controller.index,
              children: [
                const TablesPage(),
                const PlayersPage(),
                const PaymentsPage(),
                NewsPage(),
              ],
            ),
          ),
        ),
      );
    });
  }
}

DateTime? currentBackPressTime;
Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
    currentBackPressTime = now;

    Get.snackbar("", "",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(left: 100, right: 100, bottom: 100),
        animationDuration: const Duration(milliseconds: 50),
        duration: const Duration(milliseconds: 1500),
        titleText: const SizedBox(),
        messageText: SizedBox(
            width: Get.width * 0.3,
            child: Center(child: Text('presstwicetoexit'.tr))),
        borderColor: Colors.white,
        borderWidth: 1,
        borderRadius: 25,
        barBlur: 100,
        padding: const EdgeInsets.only(bottom: 3, left: 10, right: 20));

    return Future.value(false);
  }
  return Future.value(true);
}
