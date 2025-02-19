import 'package:flutter/material.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(15),
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            child: ListView.separated(
                itemBuilder: (context, inde) {
                  return ListTile(
                    title: const Text('Table Name'),
                    onTap: () {},
                    subtitle: const Text('Table Price'),
                    trailing: Checkbox(
                      value: true,
                      onChanged: (value) {},
                      activeColor: const Color.fromARGB(255, 16, 146, 20),
                      checkColor: Colors.white,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Divider(
                        color: Colors.red,
                      ));
                },
                itemCount: 10),
          )),
    );
  }
}
