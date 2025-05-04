import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snookerclub/bindings/bindings.dart';
import 'package:snookerclub/classes/myconsts.dart';
import 'package:snookerclub/classes/translate.dart';
import 'package:snookerclub/routes/routes.dart';

void main() async {
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final box = GetStorage();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    notifbarcolorbrightness(Brightness.light, myAppbarColor);
    return GetMaterialApp(
      theme: box.read('theme') ?? false ? ThemeData.dark() : ThemeData.light(),
      locale: Locale(box.read('language') ?? false ? 'en' : 'fa'),
      initialRoute: '/home_page',
      translations: Translate(),
      initialBinding: Mybindings(),
      getPages: Routes.pages,
//      initialBinding: Mybindings(),
      debugShowCheckedModeBanner: false,
    );
  }

  static void notifbarcolorbrightness(Brightness brightnes, Color color) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: brightnes, statusBarColor: color));
  }
}
