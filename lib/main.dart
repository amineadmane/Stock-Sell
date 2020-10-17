import 'package:flutter/material.dart';
import 'package:stocknsell/Screens/Historydetail.dart';
import 'package:stocknsell/Screens/homescreen.dart';
import 'package:stocknsell/Screens/AuthentificationScreen.dart';
import 'package:stocknsell/Screens/historyscreen.dart';

void main() => runApp(StocknSell());

class StocknSell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => MenuDashboardPage(),
        '/history': (context) => HistoriquePage(),
        '/historydetail': (context) => HistoriquedetailPage(),
      },
    );
  }
}
