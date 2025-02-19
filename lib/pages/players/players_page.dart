import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayersPage extends StatelessWidget {
  const PlayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      width: Get.width,
      child: const TableListView(),
    );
  }
}

class TableListView extends StatelessWidget {
  const TableListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
                padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.card_membership)),
                    ),
                    const Text('Name'),
                    Text('phone number'),
                    Text('group'),
                  ],
                ));
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: 20),
    );
  }
}
