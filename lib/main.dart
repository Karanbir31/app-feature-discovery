import 'package:appfeaturediscovery/core/app_theme/my_material_theme.dart';
import 'package:appfeaturediscovery/home_screen_controller.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_screen.dart';

void main() {
  runApp(FeatureDiscovery(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = ThemeData.light().textTheme;

    final myTheme = MyMaterialTheme(textTheme);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onInit: () {
        Get.put(HomeScreenController());
      },

      theme: myTheme.light(),
      darkTheme: myTheme.dark(),

      home: HomeScreen(),
    );
  }
}
