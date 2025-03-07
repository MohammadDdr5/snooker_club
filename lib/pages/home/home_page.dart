import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
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
            heroTag: 'hero',
            backgroundColor: const Color.fromARGB(255, 181, 13, 13),
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
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
              backgroundColor: Colors.black,
              icons: const [Icons.abc, Icons.home, Icons.book, Icons.table_bar],
              activeIndex: controller.index,
              activeColor: Colors.amber,
              inactiveColor: Colors.white,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.verySmoothEdge,
              notchMargin: 20,
              splashColor: Colors.amber,
              onTap: (index) {
                controller.changetap(index);
              }),
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
