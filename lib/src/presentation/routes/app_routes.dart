import 'package:flutter/material.dart';
import '../views/home_page.dart';

class AppRoutes {
  static const String climate = '/climate';

  static Map<String, WidgetBuilder> routes = {
    climate: (_) => const ClimatePage(),
  };
}
