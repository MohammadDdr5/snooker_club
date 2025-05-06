import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:snookerclub/controller/themeandlang_controller.dart';
import 'package:snookerclub/controller/translate_controller.dart';
import 'package:snookerclub/main.dart';

var box = GetStorage();
const Color myAppbarColor = Color.fromARGB(255, 106, 175, 231);

class MyCustomAppbartitle extends StatelessWidget {
  const MyCustomAppbartitle({
    super.key,
    required this.pagename,
  });

  final String pagename;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    pagename.tr,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'nightmode'.tr,
                    style: const TextStyle(fontSize: 10),
                  ),
                  Transform.scale(
                    scale: 0.5,
                    child: CupertinoSwitch(
                      value:
                          Get.find<ThemeandlangController>().isthemedark.value,
                      onChanged: (value) {
                        Get.find<ThemeandlangController>().themechanger();
                        if (Get.find<ThemeandlangController>()
                            .isthemedark
                            .value) {
                          MyApp.notifbarcolorbrightness(
                              Brightness.dark, myAppbarColor);
                          Get.changeTheme(ThemeData.dark());
                          box.write('theme', true);
                        } else {
                          MyApp.notifbarcolorbrightness(
                              Brightness.light, myAppbarColor);
                          Get.changeTheme(ThemeData.light());
                          box.write('theme', false);
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      );
    });
  }
}

//app action button

//

shadowbox() {
  Container(
      decoration: BoxDecoration(boxShadow: [
    BoxShadow(
        color: Get.find<ThemeandlangController>().isthemedark.value
            ? const Color.fromARGB(255, 36, 35, 35)
            : const Color.fromARGB(255, 236, 232, 232),
        spreadRadius: 2,
        blurRadius: 3)
  ]));
}

//popupaction button for appbar
Container languageMenu() {
  // ignore: avoid_unnecessary_containers
  return Container(
    child: PopupMenuButton(
        icon: const Icon(Icons.language_outlined),
        offset: const Offset(5, 55),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text(' English (EN)'),
                onTap: () {
                  Get.find<TranslateController>().changelanguage('en');
                  box.write('language', true);
                },
              ),
              PopupMenuItem(
                child: const Text('(FA) فارسی'),
                onTap: () {
                  box.write('language', false);
                  Get.find<TranslateController>().changelanguage('fa');
                },
              ),
            ]),
  );
}

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
