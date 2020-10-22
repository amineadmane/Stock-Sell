import 'package:flutter/material.dart';
import 'package:stocknsell/Screens/Historydetail.dart';
import 'package:stocknsell/Screens/Stockscreen.dart';
import 'package:stocknsell/Screens/homescreen.dart';
import 'package:stocknsell/Screens/AuthentificationScreen.dart';
import 'package:stocknsell/Screens/historyscreen.dart';
import 'package:stocknsell/Screens/Client.dart';
import 'package:stocknsell/Screens/productaddscreen.dart';
import 'package:stocknsell/Screens/productdetailScreen.dart';

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
        '/client': (context) => Client(),
        '/stock': (context) => StockPage(),
        '/productdetail': (context) => ProductDetailPage(),
        '/productadd': (context) => ProductaddPage(),
      },
    );
  }
}
