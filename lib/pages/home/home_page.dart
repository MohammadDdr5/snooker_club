import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/controller/home_controller.dart';
import 'package:snookerclub/pages/games/games_page.dart';
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
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            heroTag: 'hero',
            mini: true,
            backgroundColor: const Color.fromARGB(255, 13, 66, 181),

            onPressed: () {
              if (controller.index == 2) {
                Get.toNamed('/add_table_page');
              }
            },
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
            //params
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.blueAccent,
            items: const [
              CurvedNavigationBarItem(
                child: Icon(Icons.home_outlined),
                label: 'خانه',
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.person_2_outlined),
                label: 'بازیکنان',
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.table_restaurant_outlined),
                label: 'میزها',
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.payment_outlined),
                label: 'صورت حساب',
              ),
            ],
            onTap: (index) {
              controller.changetap(index);
            },
          ),
          body: IndexedStack(
            index: controller.index,
            children: const [
              GamesPage(),
              PlayersPage(),
              TablesPage(),
              PaymentsPage()
            ],
          ),
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Snooker Club'),
            backgroundColor: Colors.greenAccent,
          ),
        ),
      );
    });
  }
}
