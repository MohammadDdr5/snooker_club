import 'package:get/get.dart';
import 'package:snookerclub/pages/home/home_page.dart';
import 'package:snookerclub/pages/news/news_page.dart';
import 'package:snookerclub/pages/players/add_player_page.dart';
import 'package:snookerclub/pages/players/players_page.dart';
import 'package:snookerclub/pages/tables/add_table_page.dart';
import 'package:snookerclub/pages/tables/single_table.dart';
import 'package:snookerclub/pages/tables/tables_page.dart';
import 'package:snookerclub/pages/splash/splash_screen.dart';

class Routes {
  static List<GetPage> get pages => <GetPage>[
        GetPage(
          name: '/home_page',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/games_page',
          page: () => NewsPage(),
        ),
        GetPage(
          name: '/players_page',
          page: () => const PlayersPage(),
        ),
        GetPage(
          name: '/tables_page',
          page: () => const TablesPage(),
        ),
        GetPage(
          name: '/add_table_page',
          page: () => const AddTablePage(),
        ),
        GetPage(
          name: '/single_table',
          page: () => const SingleTable(),
        ),
        GetPage(
          name: '/add_player_page',
          page: () => const AddPlayerPage(),
        ),
        GetPage(name: '/splash_screen', page: () => const SplashScreen())
      ];
}
