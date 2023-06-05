import 'package:finalgame/screens/goodjobscreen/goodjobscreen.dart';
import 'package:finalgame/screens/homescreen/screen1.dart';
import 'package:get/get.dart';

import '../screens/welcomescreen/welcomescreen.dart';

class AppRoutes {
  static String welcomescreen = "/welcomeScreen";
  static String homescreen = "/homeScreen";
  static String goodjobscreen = "/goodjobScreen";

  static List<GetPage> getpages = [
    GetPage(
      name: welcomescreen,
      page: () => WelcomeScreen(),
    ),
    GetPage(
      name: homescreen,
      page: () => CameraScreen(),
    ),
    GetPage(
      name: goodjobscreen,
      page: () => GoodJobScreen(),
    ),
  ];
}
