import 'package:flutter/material.dart';
import 'package:stocknsell/Screens/homescreen.dart';

void main() => runApp(StocknSell());

class StocknSell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MenuDashboardPage(),
      },
    );
  }
}
