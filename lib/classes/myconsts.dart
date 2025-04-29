import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snookerclub/controller/themeandlang_controller.dart';
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
                    style: const TextStyle(fontSize: 15),
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
