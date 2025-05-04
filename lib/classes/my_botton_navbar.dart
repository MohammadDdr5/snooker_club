// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBottonNavbar extends StatelessWidget {
  const MyBottonNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        surfaceTintColor: Colors.amber,
        shadowColor: Colors.red,
        color: const Color.fromARGB(255, 62, 240, 119),
        shape: const CircularNotchedRectangle(),
        notchMargin: 15.0,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                width: Get.width / 2 - 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.card_membership))
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                width: Get.width / 2 - 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.table_bar)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.picture_as_pdf))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
