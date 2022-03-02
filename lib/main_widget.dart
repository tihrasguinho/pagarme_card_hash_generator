import 'package:flutter/material.dart';
import 'package:pagarme_card_hash_generator/main_page.dart';
import 'package:seo_renderer/seo_renderer.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RobotDetector(
      debug: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pagarme Card Hash Generator',
        navigatorObservers: [seoRouteObserver],
        home: const MainPage(),
      ),
    );
  }
}
