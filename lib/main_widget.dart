import 'package:flutter/material.dart';
import 'package:pagarme_card_hash_generator/main_page.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pagarme Card Hash Generator',
      home: MainPage(),
    );
  }
}
