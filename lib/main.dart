import 'package:flutter/material.dart';
import 'package:pagarme_card_hash_generator/main_widget.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MainWidget());
}
